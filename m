Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF035AC0E;
	Tue,  6 Oct 2026 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270230; cv=none; b=f8tPjC4ikjSvXRcf089RgClFPCW3oDvp4wNTjh5KHEl+BUOm/VFTXfSf+VK4hMa1RVN7mkNeVd+3T7Z6vGInkbzjR77flhXw0L0PZIXCJSt938cWBZoHq9rEUKDlsW7ds+2dmdIqSdLHzj3Bng41jstTTw9Y8HfISazhwdzEN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270230; c=relaxed/simple;
	bh=urJMZKX5f3hji+uw64p4WKt1kgEclC43kBvpa8Jf7As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9i+Z+pYi1AcontiN/gMWdHeop/iMRaXQJhDDZ9EDxdoy5sCiUdcHQkQUmI6d3Ncbe7/f5/o0+KU4qBGov4J+fyDJaCIkcvOLfzRan8gHlM7hHPa3HI63ID+P+x/PjpEA78Eeqqf62YyOXCo9ybabTg4unrJnTuycTrgOnjw3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBAQKabD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBAQKabD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85C31F000FF;
	Tue,  6 Oct 2026 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791270229;
	bh=K1hVDxTNy4viAJ8iC1aCNhcpE1Gz6aEWPwVU7NsmRaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBAQKabDZBxq9rzH2ZWl+hNAKEGRw2oT09YmBv/HV7EUfS6iimF4PEpnlC+8Y5HNq
	 TknANLC9j2W+KFT/q44N2INzQr+3HyO5kFy0SHpQg7wQdu/XXWifohUEqITeQmtE3v
	 1t7Kogb9qIGUS8b3vZidi8yA10P9DKruYsF1MxPrjhCm39PgggEbXTG9pC1eSl5Ycv
	 w+TDJFQRcs1MlqJXcVXNEDP3Q1QWPxX5FYWowFX+X2KcXTtqE1RmbU+kPUQBp47u8q
	 5cHvRp2cUKsQwSXIEu/oCTu+3jnhVkT9aDoLjxtWhDr4EpvL3VrZL1gxDTPkVJZnf/
	 K04VAmCbeG6tA==
From: SJ Park <sj@kernel.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com
Subject: Re: [PATCH 0/3] Docs/admin-guide/mm/damon: Minor fixes
Date: Tue,  6 Oct 2026 00:03:43 -0700
Message-ID: <20261006070343.43450-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006061549.627-1-adrianhuang0701@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  6 Oct 2026 14:15:46 +0800 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com> wrote:

> This small patch series fixes various typos, copy-paste mistakes, and an
> incorrect command syntax in the DAMON documentation files.
> 
> Adrian Huang (Lenovo) (3):
>   Docs/admin-guide/mm/damon: Fix various typos
>   Docs/admin-guide/mm/damon/lru_sort: Fix copy-paste mistakes
>   Docs/admin-guide/mm/damon/usage: Fix incorrect option syntax in perf
>     example

Looks good to me, thank you.

I applied this series to damon/next [1] tree.  We are now quite close to next
merge window.  I'd like us (mm and damon community) to focus on making mm.git
more stabilized and therefore ready for the next merge window, rather than
adding more changes that are not really urgent.  I understand this series is
not really urgent.  Hence, Andrew might not add this patch until next -rc1
release.  In the case, I will request adding this to mm.git after next -rc1
release.  So, no action from your side is needed for now.  Let me know if I'm
missing something.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
