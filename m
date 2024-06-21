Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435691D52C;
	Fri, 21 Jun 2024 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946012; cv=none; b=phYy5RW5sw9x6ghFHczNFdDVBLtAN9VjOhJ4DUpnEoxXQDilhWzT6G0RUb9SHyArNqDr21J3Q54+R9tgeduifoTwMQBxwe+cToZrOF/+HyBrk/LV+B/NSCQtb2TWJGN6mzh+khbUEXZG9gONyWzPLJZluBu+jbB0N46vXfxBWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946012; c=relaxed/simple;
	bh=N+HOeYMxJ4Oynd9qnidNqx76FjL3Ch8ZDXU/hRcyDvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRiWbMSCTCVctkrl6wB6sDyoOSgAgrTkR/GnqNkR5r9S/LSa6sByMResLx5lfoZezSIf0FChaj9P2/g6biHC0bSE9exNVNB3nzPggNKE/CMHnxgbkmk0Xlw+SQw9eCQ7XYk3BbJdRf8aN0wXPNZi6XBgB9N5cLGbGCeCyZn76SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P40Yn1tM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P40Yn1tM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ejaN9jzv23+csQVIqr6qNGmq0JDrOqzMj21IY9AmYOM=; b=P40Yn1tMca0expYGXzDATjHlnk
	y1eI27fIjIfQBHzHhOziu85/B1g8RJiOFXcxAVXE0vL/ATyMOB3Vzi6ppztI76vA4TfitcLbY5RU0
	KpvYDP3yzNCayhcSWDQezWplLu/Ndxm/FQ2qOR+0ZQdw/bxW0YvmfC2u/r+If2jny+nm2kL5vIYPs
	92wD2yAF0IjEJEJ2jzSs9TgDVmvu20NUY9MBgeyzjytQPhHnWEBhUl0igcALuBYs/jK81ba/KhShl
	BVyUszHiI66kFspaGIECgSRWoGhgtNDBLjjCtKjCQa9lMmA0SUi0yDAix2lrsXJqMh8ka6MqXw/bG
	8WfsPskQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKWNc-00000007hlo-08MF;
	Fri, 21 Jun 2024 05:00:08 +0000
Message-ID: <5286745e-0100-40f3-b0e9-afc204c348f2@infradead.org>
Date: Thu, 20 Jun 2024 22:00:05 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Docs/mm/damon/maintainer-profile: introduce
 HacKerMaiL
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240620220337.76942-1-sj@kernel.org>
 <20240620220337.76942-2-sj@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240620220337.76942-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/20/24 3:03 PM, SeongJae Park wrote:
> Since DAMON has merged into the mainline, I periodically received some
> questions around DAMON's mailing lists based workflow.  The workflow is
> not different from the normal ones that well documented, but it is also
> true that it is not always easy and familiar for everyone.
> 
> I personally overcame it by developing and using a simple tool, named
> HacKerMaiL (hkml)[1].  Based on my experience, I believe it is matured
> enough to be used for simple workflows like that of DAMON.  Actually
> some DAMON contributors and Linux kernel developers other than myself
> told me they are using the tool.
> 
> As DAMON maintainer, I also believe helping new DAMON community members
> onboarding to the worklow is one of the most important parts of my
> responsibilities.  For the reason, the tool is announced[2] to support
> DAMON community.  To further increasing the visibility of the fact,
> document the tool and the support plan on DAMON maintainer's profile.
> 
> [1] https://github.com/damonitor/hackermail
> [2] https://github.com/damonitor/hackermail/commit/3909dad91301
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/maintainer-profile.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> index 8213cf61d38a..aede61f2d6a8 100644
> --- a/Documentation/mm/damon/maintainer-profile.rst
> +++ b/Documentation/mm/damon/maintainer-profile.rst
> @@ -53,6 +53,22 @@ Mon-Fri) in PT (Pacific Time).  The response to patches will occasionally be
>  slow.  Do not hesitate to send a ping if you have not heard back within a week
>  of sending a patch.
>  
> +Mailing tool
> +------------
> +
> +Like many other Linux kernel subsystems, DAMON uses the mailing lists
> +(damon@lists.linux.dev and linux-mm@kvack.org) as the major communication
> +channel.  There is a simple tool called HacKerMaiL (``hkml``) [8]_ , which is
> +for people who are not very faimiliar with the mailing lists based

                               familiar

> +communication.  The tool could particularly helpful for DAMON community members

                   The tool could be particularly helpful

> +since it is developed and maintained by DAMON maintainer.  The tool is also
> +officially announced to support DAMON and general Linux kernel developement

                                                                  development

> +workflow.
> +
> +In other words, ``hkml`` [8]_ is a mailing tool for DAMON community, which
> +DAMON maintainer is committed to support.  Please feel free to try and report
> +issues or feature requests for the tool to the maintainer.
> +
>  
>  .. [1] https://git.kernel.org/akpm/mm/h/mm-unstable
>  .. [2] https://git.kernel.org/sj/h/damon/next
> @@ -61,3 +77,4 @@ of sending a patch.
>  .. [5] https://github.com/awslabs/damon-tests/blob/master/corr/tests/kunit.sh
>  .. [6] https://github.com/awslabs/damon-tests/tree/master/corr
>  .. [7] https://github.com/awslabs/damon-tests/tree/master/perf
> +.. [8] https://github.com/damonitor/hackermail

-- 
~Randy
