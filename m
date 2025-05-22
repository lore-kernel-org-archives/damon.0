Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABC1EB5E6
	for <damon@lists.linux.dev>; Thu, 22 May 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893281; cv=none; b=LC9reJ7nRGPaYqXJpKFLVxvQ+TrvrEYPTBXcpeDbdMOlEYIh5bpIsa20MeLdA+1AlHsUrryX7n76we2mKGIrlLKWlkPcI4erTZ7ZIuGfKUqLN8OIoDVIb6W5ZwjcJDMhN5Xzj6JrYAuPl5xPXFYjc9uqL6JNK/qj/w31J7EEWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893281; c=relaxed/simple;
	bh=CGJWQ8ds21rm/FLXiuPen59Qp9eRaejNGsEsevYyHoU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XzG6rOH05aSMQ5T2TDvSpBh0vKI8+ASs9p3k/2QOPTFOW0dC2MG/9af1xO5y7rkQmFM9BuzD7pphzgpKOcSKh1KdGDSlWgAPrHdRdUjnsS3cuG/neVOs4cQWJtEJv9MwUyeRbugfPa/mGr+eQkwPW2DHCjZsRwPtAaayyJdMY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-be-682ebc19f855
Message-ID: <35593bd8-85db-4490-9f18-9d9674d5c6e1@sk.com>
Date: Thu, 22 May 2025 14:54:33 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/damon/Kconfig: set DAMON_{VADDR,PADDR,SYSFS}
 default to DAMON
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20250521042755.39653-1-sj@kernel.org>
 <20250521042755.39653-2-sj@kernel.org>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250521042755.39653-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXC9ZZnoa7kHr0Mg649uhZz1q9hs3jy/zer
	xb6LQNblXXPYLO6t+c9qcfjrGyYHNo9NqzqBxKdJ7B4nZvxm8XixeSajx7mLFR6fN8kFsEVx
	2aSk5mSWpRbp2yVwZUxb8Iep4CB/xekNd9kbGLt5uhg5OSQETCT2T57OBGPfv9HNCGLzClhK
	bH2zAMxmEVCVOPT0KxNEXFDi5MwnLCC2qIC8xP1bM9hBbGaBGolZl1ewgtjCAtESJw4uBKrh
	4BAR8JFoWZ4IEhYCCh+6/J4ZolxEYnZnG5jNJqAmceXlJLDxnALGEjcuzYOqMZPo2trFCGHL
	S2x/OwcozgV05gY2iSurd7FD3CwpcXDFDZYJjIKzkJw3C8mOWUhmzUIyawEjyypGocy8stzE
	zBwTvYzKvMwKveT83E2MwFhYVvsnegfjpwvBhxgFOBiVeHgdDuhmCLEmlhVX5h5ilOBgVhLh
	jV2hkyHEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBMf03
	Q9Vf/n2rEycfXpJQrrvGb03KV3YlXYvT8pN9pG4eTPXOrP/BP8HA5lPUInG+9Ut2XD1TVrBm
	wWRGmQ+XOSZWrNt+59s+KdW1LVt5ub/7reZsX81lnriEb8Kf8CVTpp4pjhZyq/P1fdJw39FU
	Vjy90TkxqWXb803XKgJvXvz0dtHf9/sONiqxFGckGmoxFxUnAgCj2e33gQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXCNUNLT1dyj16GwdIt6hZz1q9hs3jy/zer
	xb6LQNbhuSdZLS7vmsNmcW/Nf1aLw1/fMDmwe2xa1cnmsenTJHaPEzN+s3i82DyT0ePcxQqP
	xS8+MHl83iQXwB7FZZOSmpNZllqkb5fAlTFtwR+mgoP8Fac33GVvYOzm6WLk5JAQMJG4f6Ob
	EcTmFbCU2PpmAZjNIqAqcejpVyaIuKDEyZlPWEBsUQF5ifu3ZrCD2MwCNRKzLq9gBbGFBaIl
	ThxcCFTDwSEi4CPRsjwRJCwEFD50+T0zRLmIxOzONjCbTUBN4srLSWDjOQWMJW5cmgdVYybR
	tbWLEcKWl9j+dg7zBEa+WUiumIVk1CwkLbOQtCxgZFnFKJKZV5abmJljqlecnVGZl1mhl5yf
	u4kRGNjLav9M3MH45bL7IUYBDkYlHl6HA7oZQqyJZcWVuYcYJTiYlUR4Y1foZAjxpiRWVqUW
	5ccXleakFh9ilOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwbisMFhczdinaY/3Hvfbd
	+dMzLx038OO/82Vau5nP5vC//TVharxzn0S+r5a0OqcYs3fTn5ar/JMFD99a/+zjHz6rtdd9
	M1Z8jb11qrjsvXTW58Wz1ijMlAsNOeGg0HxPdDrfiTk61k8/3pdVKTO+GJb78Sbfn8z5Bt2+
	6XWrF6RJfSuRuPd3jRJLcUaioRZzUXEiAEFzulpoAgAA
X-CFilter-Loop: Reflected

Hi SeongJae,

This is the patch I was waiting for.  Since enabling DAMON build doesn't
directly impact the kernel behaviors as it is disabled by default.

On 5/21/2025 1:27 PM, SeongJae Park wrote:
> DAMON_{VADDR,PADDR,SYSFS} are de-facto essential parts of DAMON for
> normal usages.  Because those need to be enabled one by one, however,
> and there are other test-purpose or non-essential configurations, it is
> easy to be confused and make mistakes at setup.  Make the essential
> configurations default to CONFIG_DAMON, so that those can be enabled by
> default with a single change.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index c213cf8b5638..c93d0c56b963 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -28,6 +28,7 @@ config DAMON_VADDR
>   	bool "Data access monitoring operations for virtual address spaces"
>   	depends on DAMON && MMU
>   	select PAGE_IDLE_FLAG
> +	default DAMON
>   	help
>   	  This builds the default data access monitoring operations for DAMON
>   	  that work for virtual address spaces.
> @@ -36,6 +37,7 @@ config DAMON_PADDR
>   	bool "Data access monitoring operations for the physical address space"
>   	depends on DAMON && MMU
>   	select PAGE_IDLE_FLAG
> +	default DAMON
>   	help
>   	  This builds the default data access monitoring operations for DAMON
>   	  that works for the physical address space.
> @@ -55,6 +57,7 @@ config DAMON_VADDR_KUNIT_TEST
>   config DAMON_SYSFS
>   	bool "DAMON sysfs interface"
>   	depends on DAMON && SYSFS
> +	default DAMON
>   	help
>   	  This builds the sysfs interface for DAMON.  The user space can use
>   	  the interface for arbitrary data access monitoring.

I'm not sure if I'm elighble to ack your patch, but I would like to add

	Acked-by: Honggyu Kim <honggyu.kim@sk.com>

Thanks,
Honggyu
