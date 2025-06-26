import 'package:flutter/material.dart';

class NotificationMenuWidget extends StatelessWidget {
  final List<NotificationItem> notifications;
  final VoidCallback? onNotificationTap;

  const NotificationMenuWidget({
    super.key,
    required this.notifications,
    this.onNotificationTap,
  });

  int get unseenCount => notifications.where((n) => !n.visto).length;

  void _showNotificationsMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final List<NotificationItem> visibleNotifications =
        notifications.take(5).toList();
    final bool showMore = notifications.length > 5;

    showMenu(
      context: context,
      position: position,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: Container(
            width: 350,
            constraints: const BoxConstraints(maxHeight: 400),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 10,
                  ),
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Notificaciones',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                // Lista
                Expanded(
                  child:
                      visibleNotifications.isEmpty
                          ? Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 48,
                              ),
                              child: Text(
                                'No tienes nuevas notificaciones',
                                textAlign: TextAlign.center,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.copyWith(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount:
                                visibleNotifications.length +
                                (showMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index < visibleNotifications.length) {
                                final notif = visibleNotifications[index];
                                final bool isUnread = !notif.visto;
                                final bgColor =
                                    isUnread
                                        ? Theme.of(context).colorScheme.primary
                                            .withValues(alpha: 0.05)
                                        : Theme.of(context).colorScheme.surface;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3,
                                  ),
                                  child: Material(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(16),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: () {
                                        Navigator.pop(context);
                                        onNotificationTap?.call();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              radius: 26,
                                              backgroundImage: NetworkImage(
                                                notif.imageUrl,
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    notif.title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 14,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    notif.description,
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurfaceVariant,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    notif.date,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Theme.of(
                                                                context,
                                                              )
                                                              .colorScheme
                                                              .primary
                                                              .withValues(
                                                                alpha: 0.7,
                                                              ),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(32),
                                    onTap: () {
                                      Navigator.pop(context);
                                      // Get.toNamed('/notificaciones');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.08),
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.expand_more_rounded,
                                            size: 18,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Ver más",
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelLarge?.copyWith(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
          tooltip: 'Notificaciones',
          onPressed: () => _showNotificationsMenu(context),
        ),
        if (unseenCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.surface, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 18),
              child: Text(
                unseenCount > 99 ? '99+' : unseenCount.toString(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

class NotificationItem {
  final int id;
  final String title;
  final String description;
  final String date;
  final String imageUrl;
  final bool visto;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.visto,
  });
}
