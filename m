Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387818CC15;
	Thu,  5 Jun 2025 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147652; cv=none; b=UtJItmJs0SWWOm6SoZI1a42mwTikVzsDLcq592vAZm51wEXiVWghcZAKSY1TRZfqKxk1JgXQbrVhY/Vjx+WfD0Npck6OGk9eyGMoAkkj3dOcuxyY7GzIWl3esTJrOoyJmqgA3HbIk1umWCcUROCNe3Yh4KVDWM5cLZeLyTYk7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147652; c=relaxed/simple;
	bh=qI5WL+en7z1qERl3NknbmWFblW5/UCpqfdFJL39Rm10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gk990cCUl6OlWqjDrtpTZlNv040vMSZpXjNFsR0F0XtmMkhB7bXtiLF5YCfZueaIzwWECbd1zheLE+Pw0nSzI2gC5VToo4Nu6xlE2zpP+KAhATkWbZeBfJQduzZs2WMUCad25llCPCKT1lE6k94+9LFy0ZsejituqDCT2WvlKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnLggAkM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnLggAkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27023C4CEE7;
	Thu,  5 Jun 2025 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749147652;
	bh=qI5WL+en7z1qERl3NknbmWFblW5/UCpqfdFJL39Rm10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UnLggAkMP6ZzbqLK3aFlJGXPx5FMAwHo5QwxFUKS1hKK8elMOjsu7i+htVD0vLRYv
	 PD9zqWNyaaz/UXKTwWDBjyxrCgVVI0ZI6zvpMfAcEmN14QC3LALw/KzWxKBWc39j3V
	 GE3C7S/Aj15UHf+OuUvrnfDt4/lwjBO8vQWHr2vskGsNhArDKnJsMWIZi1JyhJAHDZ
	 yZS7AduyLO0M33zB+JvlFTEbXQH0x1iH1D/gHQ2hOQUTwA34+LIdXCtQfymr4OPEgg
	 ysLoH7nXrT65m8KiiruFBIlzh4rSTGx9LhCaiWWOq3XU1oCd54VMpc47nFndjT5eM1
	 AVZjiCAJ/eO7w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Simon Wang <wangchuanguo@inspur.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"david@redhat.com" <david@redhat.com>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on sysfs-schemes
Date: Thu,  5 Jun 2025 11:20:50 -0700
Message-Id: <20250605182050.83282-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530194016.51798-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 30 May 2025 12:40:16 -0700 SeongJae Park <sj@kernel.org> wrote:
[...] 
> So I suggest to set mtc->nmask as NULL, and use alloc_migration_target() from
> __damon_pa_migrate_folio_list(), same to move_pages() system call.  To use
> alloc_migrate_folio() from __damon_pa_migrate_folio_list(), we renamed it from
> alloc_demote_folio(), and made it none-static.  If we use
> alloc_migration_target() from __damon_pa_migrate_folio_list(), there is no
> reason to keep the changes.  Let's revert those too.
> 
> Cc-ing Honggyu, who originally implemented the current behavior of
> __damon_pa_migrate().  Honggyu, could you please let us know if the above
> suggested changes are not ok for you?
> 
> If Honggyu has no problem at the suggested change, Simon, would you mind doing
> that?  I can also make the patches.  I don't really care who do that.  I just
> think someone should do that.  This shouldn't be urgent real issue, in my
> opinion, though.

This is a friendly reminder of the above.  Please let me know if you have any
opinion.  I will proceed to make the patches if I don't get other inputs by
this week.


Thanks,
SJ

[...]
