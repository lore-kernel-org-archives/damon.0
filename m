Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40143B8D4B;
	Fri, 12 Dec 2025 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579645; cv=none; b=CBTqZBn/Ahde3IXmsk6bI0w71nFKQKUJynNwdbsSpnTsg9y4ab1c6+ABL4nhM9gn9+E3Q6mm1nEVhbdllaDp15WSgZJ6sMoJdH5/QErQc66+tBux5xuXO5f75DaqUAjpZfAVXcMJtB5EHsfDwinmt68YqSYtXKH5xuIJIa4Jb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579645; c=relaxed/simple;
	bh=muNvdJh95XvWZIrWV5VMXpKvKw41GsGGnqJ9f0fd/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it/MOIR2d8ozzd5NpXYDsFEbySV6tYXC2dY1sqY22TLXhjEzc+G8pPMEom/Nt0Va3h+u3NmtF9h/x+oQe6d8XfnaXWybbYk/78eUm7fP73sJJ1QyuB8mD7o8gBR4xwFs+PquZ/wFEhraBzIPuenuAzoa1SJN7xlporAZ/8Kctss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Okg+GZKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okg+GZKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A64C4CEF1;
	Fri, 12 Dec 2025 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579645;
	bh=muNvdJh95XvWZIrWV5VMXpKvKw41GsGGnqJ9f0fd/iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Okg+GZKqOGHd5KuaRLLXMIirPVwwfuiyJcDJSnPIMgB5xI7/pqhrhmHojFaeLoXhs
	 zNvQ65kgP1wyeoUBwlB+VxJugwwojefnlZbhtfkCGhn4u6Snmx4xYjkx6Hqy683baX
	 WdavakkqYhIgvWoA5qaITXPQOW8+eYthYvhy6xlahYwipnfdTkRzTlIOyRITba1k78
	 Wj0ayfFEheDTkw4GUXSOSmwCnxUvLTp+gTLNjC9QWutQJ820ANbsdd9avbglbLXR5p
	 8i5KXAokdfdNwTgXQ9MsF1WrFBVKHAfnsd2S7GYbKexysDAECIGOJpcEgH24ay06r0
	 m1EmMycwYERtQ==
From: SeongJae Park <sj@kernel.org>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v3 04/37] mm/damon/core: implement damon_report_page_fault()
Date: Fri, 12 Dec 2025 14:47:20 -0800
Message-ID: <20251212224721.49478-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHOvCC6B1q+1TLEw5WAQM+E_L2tQQArgq=Hy5JZ35m4_H7s_5Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Dec 2025 21:46:03 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:

> On Mon, 8 Dec 2025 at 15:33, SeongJae Park <sj@kernel.org> wrote:
> >
> > Implement a DAMON core API for reporting page fault events to DAMON.  It
> > is a wrapper of damon_report_access().
> >
> > This is a temporal hack.  In future versions that will have no RFC tag,
> > only damon_report_access() may be used.
> 
> It's a minor, but git am throws an error when applying the [RFC PATCH v3 04/37]
> patch file.

Interesting.  I can do 'git am' this patch without error on mm-new branch.  Are
you using something other than mm-new as your baseline?

> I am testing it by modifying it as follows.
> damon_report_access() is
> called by damon_report_page_fault(), so they depend on each other.
> 
> #ifdef CONFIG_MMU
> void damon_report_access(struct damon_access_report *report);
> void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd);
> #else
> static inline void damon_report_access(struct damon_access_report *report)
> {
> }
> static inline void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
> {
> }
> #endif

Seems this is not for fixing a 'git am' error but build error...?  Can you
share what error exactly you are seeing?


Thanks,
SJ

[...]
