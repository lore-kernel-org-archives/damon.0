Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7352D8364;
	Sat, 15 Aug 2026 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807824; cv=none; b=tnV+NyGXkuCTzYFWby8kXPH09gONIbcuO6wKrOoFfz3mrn02ycAtF2WEA7TYu4utFFfTL4vzpQHLYsXd5kVUjlWcNaldT0CG0EoQTBAEXFDCbRLasziVVYDeiKPCPM6+8qCUprSXgRkCXTsUYAMfjF8VOVNSkVxx2SEhVN0c2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807824; c=relaxed/simple;
	bh=LtNbSsZJiASk/MNdsm1Au6JzB2HNAfG2SsiEzA+dtc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZKeHfF36N8lUkZhO4ch16CDruE1RcqcWzRLcwdeoe2PNrOKYpQaVyT6rx+7sWnGGwWQW1o1KDoXrBwUQMhfZri5bVL7X22ZKuU6ZgnM9Iio+OcjfeAQDiP5ordSCE5z825OJbxBXKhBFgA5YDDb5BSxVBQ8dzx+tQrul/CZMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/7mFSz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/7mFSz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9EE1F000E9;
	Sat, 15 Aug 2026 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786807822;
	bh=oHygruvnWfw5G8qNQHmRxC1emMqhJUV6dq/1C7tMYtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P/7mFSz7zwhCNZu5FHYBXFRj5rNBIVRelod7uvpREfSzYxpuTqZfVkJZYDH2bXPWa
	 r8BVa3t6hGsPaZZGDcMYLn7RDhLEAfQFgFIlHJD4NAADq7x4ncGuHBG865C0BNcloY
	 82GxSUvdp41dHWbkUZuFFFJ5uz5L8mb4C4Ztn4yGsf+xYCco2fK3Q/Kjusn9iOhj/m
	 v9CcEo5RULwgEdTOWru/5h5kSliDJ0bZG/70pPjyZzraxht4q7ZIJikWZ14pjnhFFp
	 bq8I/tLbl3XJpORG4fNsSl82f/gDebhl7i8uA2IWUk8hSP+hAgkA9DEqmA8VcX8RGf
	 ZNaJSYY/WRo8A==
From: SJ Park <sj@kernel.org>
To: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests: use scoped_guard() for damon_test_ops_registration
Date: Sat, 15 Aug 2026 08:30:12 -0700
Message-ID: <20260815153013.93851-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260815143039.17291-1-jaeyeon.lee.dev@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jaeyeon,


Thank you for sending this patch!

On Sat, 15 Aug 2026 16:30:39 +0200 Jaeyeon Lee <jaeyeon.lee.dev@gmail.com> wrote:

> Replace manual mutex_lock() and mutex_unlock() calls with the
> scoped_guard() macro. This simplifies the code, improves readability,
> and ensures that the lock is automatically released when the scope
> ends, preventing potential lock leaks in the future.

I'm concerned if DAMON community is not familiar enough with scoped_guard()
macro to handle it well.  At least I'm not yet familiar with it.  That said, it
seems using it for one function in the unit test could be a safe and good
start.

So I want to have this change.  It is not because I want all DAMON code to use
scoped guard, though.  I want to take this change because I want to see if it
is really safe and easy to maintain.  In other words, let's not adopt scoped
guard to more parts of DAMON code, for now.

Thank you for introducing scoped guard to DAMON!

> 
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

I applied  this patch to damon/next [1] tree.  We are now quite close to next
merge window.  We (mm community) want to focus on making mm.git more stabilized
and therefore ready for the next merge window, rather than adding more changes
that are not really urgent.  I understand this series is not really urgent.
Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
will request adding this to mm.git after next -rc1 release.  So, no action from
your side is needed for now.  Let me know if you think this is really  urgent.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
