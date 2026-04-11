Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98D9271468;
	Sat, 11 Apr 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775932042; cv=none; b=omsKJFXvkEkTp5btPu43CRBSP+1qZ1DAsEUOFM88Q8J4g13vg7j2okdFXwF8K380GK1JX49MP9WCDHOzJwMplvfsDOxUUrh5ulsWegoRffE9qRginaNshIOqFMjc1IXxNXLnFWoFkctW4tBvopmqI3sY2SF7Z99ZJMABgPXECb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775932042; c=relaxed/simple;
	bh=vqg3CJlZVe+TUMFiJkNpsyF486VMgdcyj05ctLPLOTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhlYEBQaRYDNfNWr9fxTO/SZUAaJeac4lTH79yuTgB2wK18VB2ASCXr3viUmachSVKOEPq0FbfxaW9cf/Ws/cXtmkZV/3YyAGE7TjuXkz3z5XiQVSxF4crGydJBygzFpUYiV/ryEtArgbe+UxD0KefvtXc+iJzTtHLMiUaoqRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mlw4RIO2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlw4RIO2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hItD8FmmH44C7lkQPshN1XFwsXbgSGscwro6+HDM6k8=; b=mlw4RIO2HlunldMU4GbKe5InnS
	kC48TU3cesNz1Md0KbUMo+2ThkJ3PrC5OuZgjbKNwITaGeJOFg/Il5kDexKIcQpECcXCqM7aUW4Rc
	SXLKiNxCmDfBVpnsDYd0zDtlTdqxQFLGN4AgzpTXWE/jxeMBemYMTbUqXq2k+9tYVwaYAJHc1qBLK
	ZxURLiinIc1aa8r8llkTEeyqO/TMvm73C8mDtMbEn3Q8YgnTWO9NDxA1+LEGqGbhAV8JFUWj7LzW/
	T3cL1TcK5y8mKzMInEjqhWjmYFZ8/lqPu+ZaJekzI97Tm9i50/n8XNv4T7Fna7zeD3B442eodG5oF
	hlMnPQXQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBd34-0000000DiEo-47E8;
	Sat, 11 Apr 2026 18:27:15 +0000
Message-ID: <20aa1471-5257-4913-ae46-7b40ca0aa128@infradead.org>
Date: Sat, 11 Apr 2026 11:27:14 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/mm/damon/maintainer-profile: add AI review usage
 guideline
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260411174906.79491-1-sj@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260411174906.79491-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/26 10:49 AM, SeongJae Park wrote:
> DAMON is opted-in for DAMON patches scanning [1] and email delivery [2].
> Clarify how that could be used on DAMON maintainer profile.
> 
> [1] https://github.com/sashiko-dev/sashiko/commit/ad9f4a98f958
> [2] https://github.com/sashiko-dev/sashiko/commit/b554c7b6e733
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/maintainer-profile.rst | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
> index bcb9798a27a86..5c23b1281c50c 100644
> --- a/Documentation/mm/damon/maintainer-profile.rst
> +++ b/Documentation/mm/damon/maintainer-profile.rst
> @@ -100,3 +100,24 @@ There is also a public Google `calendar
>  <https://calendar.google.com/calendar/u/0?cid=ZDIwOTA4YTMxNjc2MDQ3NTIyMmUzYTM5ZmQyM2U4NDA0ZGIwZjBiYmJlZGQxNDM0MmY4ZTRjOTE0NjdhZDRiY0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t>`_
>  that has the events.  Anyone can subscribe to it.  DAMON maintainer will also
>  provide periodic reminders to the mailing list (damon@lists.linux.dev).
> +
> +AI Review
> +---------
> +
> +For patches that are publicly posted to DAMON mailing list
> +(damon@lists.linux.dev), AI reviews of the patches will be available at
> +sashiko.dev.  The reviews could also be sent as mails to the author of the
> +patch.
> +
> +Patch authors are encouraged to check the AI reviews and share their opinions.
> +The sharing could be done as a reply to the mail thread.  Consider reducing the
> +recipients list for such sharing, since some people are not really interested
> +in AI reviews.  As a rule of thumb, drop individuals except DAMON maintainer
> +and stable@vger.kernel.org from the recipients list.
> +
> +`hkml` also provides a `feature
> +<https://github.com/sjp38/hackermail/blob/master/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list>`_
> +for such sharing.  Please feel free to use the feature.
> +
> +It is only a non-mandastory recommendation.  DAMON maintainer could also ask

                non-mandatory
or maybe
  This is an optional recommendation.


> +any question about the AI reviews, though.
> 
> base-commit: aeaae01df7d17b5742e22b65b06f666ddea76816

-- 
~Randy

