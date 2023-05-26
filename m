Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0C742EA
	for <damon@lists.linux.dev>; Fri, 26 May 2023 11:51:26 +0000 (UTC)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-33a9c8260f0so4088715ab.2
        for <damon@lists.linux.dev>; Fri, 26 May 2023 04:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685101886; x=1687693886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1f5t5EnmrzLM42NWsH81wIZzorp2FJYYxXAvKg2C+uw=;
        b=cQFVhs+V//eWlOxh+kO4IiDYye5Qpi5GKw/g7tekP+gUSbMSddSkS0oFDZPu2H8plP
         OoGSaUf4+RnJFz6y7GtkJvD4eXrU4ZIk2eb4P5mOUdfYtt7saTAM+FuerKuSJWqBlqJc
         aLgZCmojedGQHqDySvJNIUIuQXPXAyYo3cS99AuiHfN7bNTQSVQuonTYr/P/Mn5x0R/T
         yYI6UUvekgjJhmRtRfvsSXk30fl+SPp7l/YIJQaaPjVHt+7szBxE416nCUSfFBp+Xfpb
         Um/wQYrOFtTkCpJrYqRzqbCHW7IuMsGaj2qHEbbkzcIL6LdPoqZgOgiCSaLNfOgWphrW
         eDaw==
X-Gm-Message-State: AC+VfDwfWc5Q02hZbyyZ92Zs1rUKBr2B/bsdfnejHkzHN+KqxqX3osWq
	pJ96LwCTkXaUJH76PXVa6TZgolb1qWxnINfZmrLLgXnuiZir
X-Google-Smtp-Source: ACHHUZ73tMOTB3cIidXPBwDaGhnqzT5rTGVtRWsnD7enx5kkD+BWBI7ygTW/igj3tFFkpj+cSYFcAMEr2XOP6zZHMMtKJMCpSfM7
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c942:0:b0:335:de72:23d7 with SMTP id
 i2-20020a92c942000000b00335de7223d7mr644994ilq.3.1685101886173; Fri, 26 May
 2023 04:51:26 -0700 (PDT)
Date: Fri, 26 May 2023 04:51:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055fc4e05fc975bc2@google.com>
Subject: [syzbot] [damon?] divide error in damon_set_attrs
From: syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    44c026a73be8 Linux 6.4-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a92b31280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f389ffdf4e9ba3f0
dashboard link: https://syzkaller.appspot.com/bug?extid=841a46899768ec7bec67
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35f16ee05df7/disk-44c026a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10399498a570/vmlinux-44c026a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c72201ea4ba/bzImage-44c026a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 13527 Comm: syz-executor.1 Not tainted 6.4.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:damon_nr_accesses_to_accesses_bp mm/damon/core.c:491 [inline]
RIP: 0010:damon_nr_accesses_for_new_attrs mm/damon/core.c:497 [inline]
RIP: 0010:damon_update_monitoring_result mm/damon/core.c:506 [inline]
RIP: 0010:damon_update_monitoring_results mm/damon/core.c:534 [inline]
RIP: 0010:damon_set_attrs+0x224/0x460 mm/damon/core.c:555
Code: 03 42 0f b6 04 20 84 c0 74 08 3c 03 0f 8e b3 01 00 00 48 8b 43 08 31 d2 41 69 4f 18 10 27 00 00 48 f7 33 31 d2 48 89 c7 89 c8 <f7> f7 31 d2 49 8d 7f 30 89 c1 49 8b 46 08 49 f7 36 0f af c8 b8 59
RSP: 0018:ffffc90011627be8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888015a88800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e2f0e0 RDI: 0000000000000000
RBP: ffff88802b5ae710 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88802b5ae700 R14: ffffc90011627c60 R15: ffff88802ef03058
FS:  0000000000000000(0000) GS:ffff8880b9900000(0063) knlGS:00000000f7f1db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f72b2f2b CR3: 00000000295e7000 CR4: 00000000003506e0
DR0: 00000000000017b9 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dbgfs_attrs_write+0x225/0x280 mm/damon/dbgfs.c:101
 full_proxy_write+0x11c/0x190 fs/debugfs/file.c:236
 vfs_write+0x2ae/0xd50 fs/read_write.c:582
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f22579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f1d5cc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020000040
RDX: 0000000000000069 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:damon_nr_accesses_to_accesses_bp mm/damon/core.c:491 [inline]
RIP: 0010:damon_nr_accesses_for_new_attrs mm/damon/core.c:497 [inline]
RIP: 0010:damon_update_monitoring_result mm/damon/core.c:506 [inline]
RIP: 0010:damon_update_monitoring_results mm/damon/core.c:534 [inline]
RIP: 0010:damon_set_attrs+0x224/0x460 mm/damon/core.c:555
Code: 03 42 0f b6 04 20 84 c0 74 08 3c 03 0f 8e b3 01 00 00 48 8b 43 08 31 d2 41 69 4f 18 10 27 00 00 48 f7 33 31 d2 48 89 c7 89 c8 <f7> f7 31 d2 49 8d 7f 30 89 c1 49 8b 46 08 49 f7 36 0f af c8 b8 59
RSP: 0018:ffffc90011627be8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888015a88800 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e2f0e0 RDI: 0000000000000000
RBP: ffff88802b5ae710 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88802b5ae700 R14: ffffc90011627c60 R15: ffff88802ef03058
FS:  0000000000000000(0000) GS:ffff8880b9800000(0063) knlGS:00000000f7f1db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002cc30000 CR3: 00000000295e7000 CR4: 00000000003526f0
DR0: 00000000000017b9 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 42 0f             	add    0xf(%rdx),%eax
   3:	b6 04                	mov    $0x4,%dh
   5:	20 84 c0 74 08 3c 03 	and    %al,0x33c0874(%rax,%rax,8)
   c:	0f 8e b3 01 00 00    	jle    0x1c5
  12:	48 8b 43 08          	mov    0x8(%rbx),%rax
  16:	31 d2                	xor    %edx,%edx
  18:	41 69 4f 18 10 27 00 	imul   $0x2710,0x18(%r15),%ecx
  1f:	00
  20:	48 f7 33             	divq   (%rbx)
  23:	31 d2                	xor    %edx,%edx
  25:	48 89 c7             	mov    %rax,%rdi
  28:	89 c8                	mov    %ecx,%eax
* 2a:	f7 f7                	div    %edi <-- trapping instruction
  2c:	31 d2                	xor    %edx,%edx
  2e:	49 8d 7f 30          	lea    0x30(%r15),%rdi
  32:	89 c1                	mov    %eax,%ecx
  34:	49 8b 46 08          	mov    0x8(%r14),%rax
  38:	49 f7 36             	divq   (%r14)
  3b:	0f af c8             	imul   %eax,%ecx
  3e:	b8                   	.byte 0xb8
  3f:	59                   	pop    %rcx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
