Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EB413224;
	Wed,  4 Feb 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219810; cv=none; b=n7iYXyOtxMcbaV12yG0Hixky3Cx4anQT/C99yGNSUPd8/gLZ2haYsvFrUoV9Vxmk6ojpxgD0+n3nmcj7q3r3Eqz928Z869AlkmOqCkND7NC8cP7neQMHc/+48FKrwPrwTmEDlL0yeAA3RKpS0sAwCsokXzzecm62Azi5oBXuVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219810; c=relaxed/simple;
	bh=Axbp5hUl8npKt0WGTCQFeaQ4EcYxU7hzPCvTCkrlP5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyoitE5UBPiZ1MrIcHAxScUzg01MsgB+pqkgm7LywqCkrW99f1emllKziSSwTRQQ7miqUk4blXluVrT9K5g2TUYzzPk+SxcJ4hSX7ZsYwgennHDYiWDxIAgwTNIh1iwrBG/MTDabg1YGCKnes3DZd+PzKKztzbTvyxFiPMPAVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPZZro8v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPZZro8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FD5C4CEF7;
	Wed,  4 Feb 2026 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770219810;
	bh=Axbp5hUl8npKt0WGTCQFeaQ4EcYxU7hzPCvTCkrlP5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPZZro8vd+CEap7faYo2Y06FFlw4uMU4KKKzjvXbqO4QrDrZ9uZf0QZZIBCHhRAL8
	 ygnLnOXVGs7DShWU3aPAtMJfjEsdFZgCuoO4E/7kakEQ04lPFK6QNniPB9LZfPuRbo
	 1n9CFcr0Mh1DWN3krmPIusnsFdUZDlU5FchVmtLziuk1bpPVx+wjsGSxpYunEVKkcM
	 JyEUZ/WZDgCLzvwaYRnBVM4TVUxTOqUtWbBR0ryImVEY9cDtV+usw+L7y0s6Bj+oNV
	 DUpSM7LeN4YPT0b7FiJ0kKhAJbNWAJBYQojBPmodi/usMTUtgZlyFc3oIw4XCqqtRA
	 zY9Lr0s7xRFjA==
From: SeongJae Park <sj@kernel.org>
To: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] mm/damon: Support hot application detections
Date: Wed,  4 Feb 2026 07:43:20 -0800
Message-ID: <20260204154321.18577-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8b8e9dde-33ff-41f7-8563-d9aeaf5efeb5@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Feb 2026 16:07:40 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:

> 
> 
> On 2/4/2026 10:17 AM, SeongJae Park wrote:
> > On Tue, 3 Feb 2026 17:25:11 +0300 Gutierrez Asier <gutierrez.asier@huawei-partners.com> wrote:
> > 
> >> SeongJae,
> >>
> >> Thanks a lot for all the useful feedback.
> > 
> > The pleasure is mine! :)
> > 
> >>
> >> One thing that I was not sure about while working on this patch set
> >> is whether to have an external new module or adding the logic to 
> >> damon core. I mean, the hot application detecting can be useful for
> >> all other modules and can improve DAMON performance.
> > 
> > All exising non-sample DAMON modules are working for the physical address
> > space.  I hence finding no many opportunities to bring benefits of hot
> > application detection to those.
> > 
> > I agree the hot applications detection could be useful in general and creative
> > DAMON use cases for virtual address spaces.  Implementing the feature in DAMON
> > core layer and exposing it via DAMON sysfs interface will help such use cases.
> > But it seems not straightforward to imagine how the sysfs interface can be
> > extended for the feature.
> > 
> > So, I think it would better to be implemented inside the new module at the
> > moment.  Later, if we end up having more modules that use the feature, we could
> > move it to the modules-common or the core.  If we further find a good way to
> > integrate that with sysfs interface, definitely it could go to core.
> > 
> > From this point, however, I realize the feature can also be implemented in the
> > user sapce in a pretty straightforward way.  Have you considered that?
> 
> I though about it. However, accessing the task_struct directly and extracting
> the utime is much more efficient that getting the required info from the user
> space.
> 
> > 
> >> What do you think?
> >> My implementation was module based because I tried to avoid changes
> >> to DAMON core for the RFC.
> > 
> > If there is a good reason to implement that not in the user space but the
> > kernel space, as I mentioned above, it seems the module is the right place to
> > me.

I agree it would be much more efficient to do that in the kernel space.  But,
given existence of 'top' like user space programs that also does similar works
and heavily used, I'm not directly feeling how important the efficiency is in
the real life.

Meanwhile, doing it in the user space (DAMON user-space tool or your own one)
would be simpler and more flexible.  For example, you could simply use 'ps
--sort=%cpu', and make the sorting algorithm flexible (e.g., sorting by RSS or
using different sorting algorithms) without changing kernel.

So there are pros and cons, to my humble view.  Those may depend on the given
use case, and I want to focus on your planned or expected use case.  Could you
please clarify your planned or expected use case, and how important and trivial
the pros and cons of keeping the logic in kernel or user space would be on the
scenarios?


Thanks,
SJ

[...]
