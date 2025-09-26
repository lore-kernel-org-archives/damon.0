Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A534BA4D
	for <damon@lists.linux.dev>; Fri, 26 Sep 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908235; cv=none; b=SqWgFgMjK4s9TlOCg9eVdA8VDLvj8OkukNkMetIXR0kuKuFHtokP22FVDETqw0uaVWufPBse3CQOHPtxR4lfzlHnRlC9dkZ+ci2VeTwWHE8fYQoTJmabDPO8r+06UWcLTi6+BzDFr6+lSEJtDJopzakHDG5GJqClmZXT5ZJD84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908235; c=relaxed/simple;
	bh=ZIQTWbCZfR8FK3ub+elpIulA3vUSjsCf39jPCJHyQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8HrCEXCAiyLCRX0w8GQlMKf2nfPhgPhVzR1snRBl+Lw1isRds3hDIx96h96bUiG93+Q3XwcvpAlNbaybCxzF9dcCZg0BEDHGJe1Cqj6ZfAXl1uqZPhFy6SdY7tU1XHUfghBMQ0Z2esmMPnwEbapMVl9frp+yWMe1CBYbNqRGsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH102F6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH102F6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A4DC4CEF4;
	Fri, 26 Sep 2025 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758908234;
	bh=ZIQTWbCZfR8FK3ub+elpIulA3vUSjsCf39jPCJHyQVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TH102F6oqAMPPmeCl7hONVN1DFJjSrbO+wD+LsFns14LvciCBESGX5ckHOI1bgxIs
	 0ErX1wonsGiKcr53AAQQcVN+BWxfIzcWNsc6N+161F8JPWbaE4wID26bls5hoe7Z8w
	 69R1mYo5eSck/oQoeSItuoq93FmsTdbWOU7AY/bLmMPM3DOPEF5p5zBbgFc3ddcEJF
	 H0TjCe1HzpEnmR3tE/NqvQJWYIiubHQPcL+/dZ6BoTKq8PcZCkB5fvvcdEo7dF628A
	 S9Z6ZwjgUKAT1mqB9qLg9TL6cVKMKNN00kDvyMaXKfUAepx3Cv4/nAWmJ0oc/g8eAc
	 puhVplwvfh8Jw==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com
Subject: Re: [RFC PATCH 0/2] DAMON: add priority-based scheme application control
Date: Fri, 26 Sep 2025 10:37:12 -0700
Message-Id: <20250926173712.53778-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87bjmxvqve.fsf@>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Sep 2025 11:23:33 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Hello SJ,
> 
> On Mon, Sep 22 2025 at 06:01:32 AM -0700, SeongJae Park wrote:
> 
> > Hello Enze,
> >
> > On Mon, 22 Sep 2025 18:10:20 +0800 Enze Li <lienze@kylinos.cn> wrote:
> >
> >> This patchset introduces a priority mechanism for DAMON's scheme
> >> application, allowing users to specify the relative importance of
> >> monitored processes.  The changes ensure that higher-priority targets
> >> receive more frequent memory management operations while maintaining
> >> fairness across all monitored processes.
> >
> > Thank you for this patchset.
> >
> > There are features for monitoring target-based DAMOS filtering
> > (DAMOS_FILTER_TYPE_TARGET) and per-scheme applying time interval
> > (apply_interval_us).  Couldn't those be used for your purpose?
> >
> 
> Sorry for the delay.  I've been testing it for the past few days.

No worry, take your time! :)

> 
> The combination of schemes and filters does indeed emulate a
> priority-like mechanism quite effectively.  This is a fantastic feature!
> It's exactly what I needed for managing my workload's priorities.

Thank you for letting me know it works for you!

[...]
> I've been wondering, though -- for users seeking a simpler interface,
> could we allow them to define a basic priority value and let the kernel
> handle the resource distribution automatically?  This would require the
> DAMON system to intelligently translate a user-defined priority value
> into appropriate internal operations based on current system resources.
> WDYT?

I agree the priority based interface could be better and easier to use than the
target filter + apply_interval combination, for some people.  That said, the
user interface for achieving the same goal already exists.  I think adding
another user interface here could be a duplicate that only increases maintenace
burden.  Particularly because we need to support every user interface of the
kernel for long term, the burden may be not that cheap.

And I think the kernel ABI is not necessarily the only single place that can be
modified to help users.  Users are recommended to use DAMON user-space tool
(damo) rather than directly using DAMON sysfs ABI.  So I think we could add
priority based interface as another wrapper of the target filter +
apply_interval combination, on DAMON user-space tool.


Thanks,
SJ

[...]
