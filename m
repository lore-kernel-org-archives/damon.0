Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B77C
	for <damon@lists.linux.dev>; Mon, 31 Oct 2022 18:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDFFC433D6;
	Mon, 31 Oct 2022 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667241032;
	bh=SJ1Z220OaKsIBgx1R0J98wMJy/gtWfntG2gf3M3ljf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PfgjHGgCeq0tU3bP4CnPXKs0ndwNt3rpKv7/xhNwOjd8m+hihm7LI2pjFlmbflO/Q
	 M9xeZ6+qyRAHq8F7SYnd3MhIlylR6dGnco4kIKSukxa6c7r8OSdVgpMhmLqeNo3/pK
	 Z6Fr0mbG1CE4aFblkA31JVZ5ry6qqKGmLPX4j7IXmdnqrhMtkQ5teLKNjzigSN8gYo
	 2pflaB8u3Y1KQDbWhBffaZwoBjKUBr5/vIaIx5sR5YSJ1G3WaQ7UQ3Y1noqIS+LEwK
	 XSbp12ldLLmwo677+VLdXGJQx4d7+xWJgNKQ/0pus0JL+dEKqWJiu2qW2WzZ6bDjK7
	 cwR9PboSQVq6g==
From: SeongJae Park <sj@kernel.org>
To: syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	sj@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in dbgfs_rm_context_write
Date: Mon, 31 Oct 2022 18:30:30 +0000
Message-Id: <20221031183030.7961-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000ede3ac05ec4abf8e@google.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Sun, 30 Oct 2022 18:44:35 -0700 syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98555239e4c3 Merge tag 'arc-6.1-fixes' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12508922880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=6087eafb76a94c4ac9eb
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167e3f4a880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1262cb86880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b9ab8f713204/disk-98555239.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5efa1b178038/vmlinux-98555239.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/83329b87f1a8/bzImage-98555239.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 PID: 3603 Comm: syz-executor414 Not tainted 6.1.0-rc2-syzkaller-00078-g98555239e4c3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:928 [inline]
> RIP: 0010:dbgfs_rm_context_write+0x2e3/0x4d0 mm/damon/dbgfs.c:971

Thank you for this report.  I just posted a patchset[1] for the fix and
selftest repro of this bug.

[1] https://lore.kernel.org/damon/20221031182554.7882-1-sj@kernel.org/

Thanks,
SJ

[...]
