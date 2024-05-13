Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BA14D2BF
	for <damon@lists.linux.dev>; Mon, 13 May 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601568; cv=none; b=A7VB41/gXZJD9Jg1NpmxlKFHxagaMrRayBYU5ArX1ADd0uykr9bEF/DdwrxYBnPvxXk+WSdhZLgjED4i9H160rijlHk3rHkdbfglBZG89tiCEk2bFuGJA5aIktsQa+c9Z43DYcBqEMF8670j9olmDI/g/dRXnRhyb45jvTxJP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601568; c=relaxed/simple;
	bh=TNgnzQqPq8Kz9uzS//yGwb0Uho0xHiz8NJ00cchimPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjtNzQQzLJZw0zbRkHXQl1S9lG/LTO92WnIP1Y82mwGqivYMJFWuBtY+yhRBHyRz6u9HJ7MOmVd5yVkGoOTbhF70UDSK2pTdF5G5mgNFg66/BBt1D9Ebbfo4XOgZResVLLY7qWD/oF9yeSzKAHxOV6dWeT+LYe2I0FpFsvrtMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-bd-66420098b2c9
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Rakie Kim <rakie.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [RFC PATCH v4 0/5] DAMON based tiered memory management for CXL memory
Date: Mon, 13 May 2024 20:59:15 +0900
Message-ID: <20240513115918.1479-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240512175447.75943-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnke5MBqc0g9uqFnPWr2GzePL/N6vF
	5V1z2CzurfnPanFk/VkWi81nzzBbLF6uZrGv4wGTxeGvb5gcOD2Wnn7D5tGy7xa7x6ZVnWwe
	mz5NYvc4MeM3i8eLzTMZPT5vkgtgj+KySUnNySxLLdK3S+DK2Hn5CVPBMq6KgxvXsTcwruTo
	YuTkkBAwkbi/cyk7jP3q3U0mEJtNQE3iystJYLaIgKLEuccXWbsYuTiYBdYzS6y/cooZJCEs
	ECzRfqyFBcRmEVCVWNJ2HmwQr4CZxLnXv1ghhmpKPN7+EyzOKWAssbjzASOILSTAI/Fqw35G
	iHpBiZMzn4DNYRaQl2jeOpsZZJmEwHU2iZMtHUwQgyQlDq64wTKBkX8Wkp5ZSHoWMDKtYhTK
	zCvLTczMMdHLqMzLrNBLzs/dxAgM6mW1f6J3MH66EHyIUYCDUYmHN+G0Q5oQa2JZcWXuIUYJ
	DmYlEV6HQvs0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxS
	DYyeIvMS8u42XJ6wYXW96nRe+bWLk+c6JIWH3e9dYP0v+L2T81q2ag+PRRXKPE1C9r5/xLQK
	ToWbTBcL81UU2VdzLqPw7c+V+dd8r9g3rPiY48Jz4kHtl43Oz1bqNk+0L1XaW7nvWnaZ5q/Q
	BT+7zAN3OsqW5z1ZYLY5+L76rS7XN2VV+3N5DiuxFGckGmoxFxUnAgAjYSjrZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsXCNUNLT3cGg1OawZv1BhZz1q9hs3jy/zer
	xednr5ktOp98Z7Q4PPckq8XlXXPYLO6t+c9qcWT9WRaLzWfPMFssXq5mcejac1aLfR0PmCwO
	f33D5MDrsfT0GzaPln232D02repk89j0aRK7x4kZv1k8Xmyeyejx7baHx+IXH5g8Pm+SC+CM
	4rJJSc3JLEst0rdL4MrYefkJU8EyroqDG9exNzCu5Ohi5OSQEDCRePXuJhOIzSagJnHl5SQw
	W0RAUeLc44usXYxcHMwC65kl1l85xQySEBYIlmg/1sICYrMIqEosaTvPDmLzCphJnHv9ixVi
	qKbE4+0/weKcAsYSizsfMILYQgI8Eq827GeEqBeUODnzCdgcZgF5ieats5knMPLMQpKahSS1
	gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmAoL6v9M3EH45fL7ocYBTgYlXh4E047pAmx
	JpYVV+YeYpTgYFYS4XUotE8T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpa
	kFoEk2Xi4JRqYDwqGf684+zajwV7eOZ1SCnsU3RTn/1/9anuxlrzh4YmO/Wndk+zqSlck3s0
	X+zmzIvPFyW4f1H64aClLuocvWPDvYzKTadY3y7llBBmfjJDxm/rpTN3ko9Yp7XE8R+flv1m
	wf3s8uirG3WuOt5QnlE+1z9E5ze77m2nE9cDi0T4IpSNl082Oq3EUpyRaKjFXFScCABjKWO8
	YQIAAA==
X-CFilter-Loop: Reflected

Hi SeongJae,

Thanks very much for your work!  It got delayed due to the priority
changes in my workplace for building another heterogeneous memory
allocator.
https://github.com/skhynix/hmsdk/wiki/hmalloc

On Sun, 12 May 2024 10:54:42 -0700 SeongJae Park <sj@kernel.org> wrote:
> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
> 
> It says there is no implementation of the demote/promote DAMOS action
> are made.  This RFC is about its implementation for physical address
> space.
> 
> Changes from RFC v3
> (https://lore.kernel.org/20240405060858.2818-1-honggyu.kim@sk.com):

This link cannot be opened.  I will share the link again here.
https://lore.kernel.org/all/20240405060858.2818-1-honggyu.kim@sk.com

>   0. updated from v3 and posted by SJ on behalf of Hunggyu under his
>      approval.
>   1. Do not reuse damon_pa_pageout() and drop 'enum migration_mode'
>   2. Drop vmstat change

I haven't checked whether I can collect useful information without
vmstat, but the changes look good in general except for that.

>   3. Drop unnecessary page reference check

I will compare this patch series with my previous v3 patchset and get
back to you later maybe next week.  Sorry, I will have another break
this week.

Thanks,
Honggyu
