Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC89EEBD
	for <damon@lists.linux.dev>; Tue, 29 Jul 2025 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828888; cv=none; b=ZE1v3m0BwIRIk7hJIQlclnToQyWXme4IruMNVZupT/pmA4m0VvyPo91JghRWWrkP6C/IQp1MAndICAAkafBXRj3V+r1raKTVd6K1oLkAMLEQzRUpGnNrtmH0A2enFo0/RFITWazPHpTIvh4987+dtgR+OPvNGSDuwTVjlE4WkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828888; c=relaxed/simple;
	bh=aY21JWEcSkOfoBtYAp4LMcNGPtZNsu/TLG9p1LytSRY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dYYOk/bPZ4T7a1P0BJsMy53CIJw8ARfPPXI6+mwCin19mRSIYo3I3mm1QSgCZamFJ2W/z5j2uKogKEPG0QJaY+MBbjlDtQOPAlK5wJsxAUE4tfSgta+HVSOu+6BIqZ286oiRheRMXZa2H2WXqReh4xG9euIe41OauBLNMhT21UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-79-68894e0d6978
Message-ID: <dcbc29a1-fbaf-4e34-a5a5-64a7882c0013@sk.com>
Date: Wed, 30 Jul 2025 07:41:17 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm/damon/design: fix typo
To: Sang-Heon Jeon <ekffu200098@gmail.com>, sj@kernel.org
References: <20250729144414.31958-1-ekffu200098@gmail.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250729144414.31958-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC9ZZnkS6fX2eGweHfjBZP/v9mtTjxIsHi
	3pr/rBaHv75hcmDx2DnrLrvHplWdbB6bPk1i93ixeSZjAEsUl01Kak5mWWqRvl0CV8arhQkF
	W7grjs+awdbAOI2zi5GTQ0LARGLT7H4mGPvcsbuMXYwcHLwClhI/ZtWAhFkEVCWO/3jKDmLz
	CghKnJz5hAXEFhWQl7h/awZYnFnATeLq9XvsIK3CAsYS1xbGgpgiQFNu7zIGqRASsJJo/Led
	CaJaRGJ2ZxsziM0moCZx5eUksDingLXE0fO9UDVmEl1buxghbHmJ7W/nANVzAR05g03i8aEz
	jBAXS0ocXHGDZQKj4Cwk181CsmMWklmzkMxawMiyilEoM68sNzEzx0QvozIvs0IvOT93EyMw
	vJfV/onewfjpQvAhRgEORiUe3h0bOjKEWBPLiitzDzFKcDArifAWLG3LEOJNSaysSi3Kjy8q
	zUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBozVfIvkq2Va42gZWpaGmM61W/
	2KVmrxXf1xf/+3SvPfGN6MvsJwtZduRfvyfBcb/v1twDKiWBgfNlWdN7PtV6JizO25N669eB
	fc8tzsc41rzn+/pOcf3ErPs9r+Qu7L9V4+DhUbruxfcdKcWV86qvn9QXfCf4nltr4vbCTYJX
	j3HV1uS35i5TYinOSDTUYi4qTgQAWTZcq2sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsXCNUNLT5fXrzPD4HKLicWT/79ZLU68SLA4
	PPckq8W9Nf9ZLQ5/fcPkwOqxc9Zddo9NqzrZPDZ9msTu8WLzTEaPxS8+MAWwRnHZpKTmZJal
	FunbJXBlvFqYULCFu+L4rBlsDYzTOLsYOTkkBEwkzh27y9jFyMHBK2Ap8WNWDUiYRUBV4viP
	p+wgNq+AoMTJmU9YQGxRAXmJ+7dmgMWZBdwkrl6/xw7SKixgLHFtYSyIKQI05fYuY5AKIQEr
	icZ/25kgqkUkZne2MYPYbAJqEldeTgKLcwpYSxw93wtVYybRtbWLEcKWl9j+dg7zBEa+WUiO
	mIVk1CwkLbOQtCxgZFnFKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGKzLav9M3MH45bL7IUYB
	DkYlHt4dGzoyhFgTy4orcw8xSnAwK4nwFixtyxDiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWe
	miAkkJ5YkpqdmlqQWgSTZeLglGpgrGVh802Ya3/kE7/AGaZVScn2y+JFfI40ailJ2SdY+9st
	nXJEnVH2wlJnPeP4u98DgyJWtmmccmA876ewfY2Vo43y5kWlPB6sO19+r+RhKlttIyV5Wk90
	F5uGq/w+fSErvs3u3U5MjQv9Hqy+2btvUn/xomPOJfOcr4Xz/vz+/WXpurI3M+uVWIozEg21
	mIuKEwE9yXaZUgIAAA==
X-CFilter-Loop: Reflected

Hi Sang-Heon,

On 7/29/2025 11:44 PM, Sang-Heon Jeon wrote:
> There are some typo in statistics section of DAMON design docs
> - sz_trtied -> sz_tried
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> While studying about DAMON subsystem, I found some typos in docs.
> This is my first kernel patch. So if there are any mistakes, please let
> me know. I'll try to fix as soon as possible. Thanks for reviewing.

It's great to see you here again :)

> 
> ---
>   Documentation/mm/damon/design.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index 03f8137256f5..2f6ba5c7f4c7 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -689,7 +689,7 @@ DAMOS accounts below statistics for each scheme, from the beginning of the
>   scheme's execution.
> 
>   - ``nr_tried``: Total number of regions that the scheme is tried to be applied.
> -- ``sz_trtied``: Total size of regions that the scheme is tried to be applied.
> +- ``sz_tried``: Total size of regions that the scheme is tried to be applied.
>   - ``sz_ops_filter_passed``: Total bytes that passed operations set
>     layer-handled DAMOS filters.
>   - ``nr_applied``: Total number of regions that the scheme is applied.
> --
> 2.43.0
> 
> 

Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>

Thanks,
Honggyu
