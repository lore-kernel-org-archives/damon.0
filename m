Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D807288AD
	for <damon@lists.linux.dev>; Sat,  4 Apr 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775333906; cv=none; b=dBcQc18i1Ung4nLy7UOLBq+tKWyNLJAZ86onB1WN/bCxbW47NcgfP5rbQR1XsbMktwOKJj6AdrdvZ0R2ywDqvroxzi26i2LF5s60ejmEBSJPyPLxy68rISOKhhxLsqr/LSSlwmTjIRzkdGkpwvofHbSeTgUvuNpIDSkrMiyzuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775333906; c=relaxed/simple;
	bh=K6O4i08ap+LxKyMLBh3GuSwkcMBslt2u7/g+pm5nHNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHFdRrcHuAr8kxvW1CJLxoNZARDmvm7+ZPyz37cBbK48moA6DvBfnFTCUcglbI7jnwzIQZ2KttO3KUG4KHwatVTFH1PBfwPU+x4P3T/lT6YuLFUJHa/yrJTUQcvYUE4UhS+xLrA0uobDcNIL99hFdx/C5hOqEegHV2kek+ymQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek8unC4z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek8unC4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55CEC19421;
	Sat,  4 Apr 2026 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775333906;
	bh=K6O4i08ap+LxKyMLBh3GuSwkcMBslt2u7/g+pm5nHNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ek8unC4z3EgITSjggKAHQB7m5LIA5qkhMQrgOAp9HyruoyzSCFZ+cttIS+GHuXphO
	 8s1OiCEVoYyxfMZarOvxWzm5zNhiaCGyg9C8JwFi+nR6MXnf7oPFFnwd4zKwTtcCWO
	 OnMJo0KoKOFts8kyF/zqnLXbq0jBwItQsRCuv+sHkRm7pK7Jrg8bK0Ez48IlMXsCWL
	 4r7VZOtFykyH6Q2OnEsppFPfhHWAIyidvmnqLklxlmt23NTU7UCq3u2bfR3C0YlvDp
	 dpBeBAX9vM1NM9Edc0DKBhQqqUSCbRooqESFb2PFnxu1QTCVIE4wcrIsiOT6i0noMI
	 TdN4SNCJWUstw==
From: SeongJae Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sat,  4 Apr 2026 13:18:21 -0700
Message-ID: <20260404201822.86511-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404090927.6055-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  4 Apr 2026 17:09:27 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri,  3 Apr 2026 08:55:29 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > I recently learned not everyone is interested [1] in sashiko review.  So when
> > I sharing sashiko review, I now try to drop recipients who are not necessarily
> > interested in the review.  My choices at the moment is the author of the patch,
> > maintainers of the subsystem, and the mailing lists of the subsystem.
> > 
> > So if I was sharing this review, I would dropped stable@ and yanquanmin1@ from
> > the Cc list.
> > 
> > Please consider doing similar when you share sashiko review.
> > 
> > Everyone including myself is learning how to use sashiko well, so it could be
> > confusing.  Sorry about that.  I'm planning to make a guideline for sashiko
> > review usage in DAMON subsystem, and update hkml to embed it, hoping that to
> > help reducing some of the confusion.
> 
> Thank you for the guidance, I will keep this in mind for future Sashiko
> review forwards.

No worry.  I just pushed hkml change for this.  The latest version of hkml will
add the guide to the forwarding mail draft and make the format easier to add
your inline comments together, by default like below:

    $ hkml patch sashiko_dev 20260325013939.18167-1-aethernet65535@gmail.com --for_forwarding

    Adding your opinion together with the sashiko review sharing
    is a recommended practice for reducing traffic.  Will you
    do so?  If so, I will adjust format to be easier for that
    [Y/n]
    # sashiko review suggestions
    #
    # 1. Consider reducing recipients.  Maybe the author,
    #    maintainers, reviewers, and mailing list of the
    #    direct subsystem and parent susystem mailing lists
    #    could be a starting point.
    # 2. Add short summary of your opinion at the beginning.
    #    For example:
    #
    #      sashiko found an issue.  I will respin this patch.
    #      sashiko found no issue.
    #
    # Please don't forget removing this comment block before
    # sending this!

    Forwarding sashiko review in a reply format with my inline
    comments below, for details of my view and doing discussions
    via mails if needed.

    > # review url: https://sashiko.dev/#/patchset/20260325013939.18167-1-aethernet65535@gmail.com
    > # start of sashiko.dev inline review
    > commit 60ccea4154b0c58741fae2323454a5a9496b67fa
    > Author: Liew Rui Yan <aethernet65535@gmail.com>
    [...]

> 
> > Anyway, seems sashiko found no blockers for this patch.
> 
> And thank you very much for reviewing the review! :>

I'm happy to help :)


Thanks,
SJ

[...]
