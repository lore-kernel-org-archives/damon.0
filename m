Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774872;
	b=b3grko1O0g5Z0Z4l4AVItuXEYSHEP6hs8yC9cQxe30HyXHiFcenbdvEF1rHEw1cBa9lT
	 l5d/3DKBk7l6A1M/BsyGiEhu2sExDlUCgDL/5evTGDZf/u08gi6vqiYHSFArutLGXK4ls
	 3RCgsaSskIhVIJtYNbqKb59Nad6NZ5eqqW84dauH84pIv9kCWjFdtUAJFIioaMcPvQmIF
	 8VkNRxAmkRZz2WkdPoEuQQxg3mcXpfCnWToztw3rqpFIX2saXanklrAdhqw8lcdTR3VUP
	 eM31f+tpd4Yv8+yLgHNyncXvFjxZ+/lZGvaLGbYPYBdiiSZOvfs4AZo7PItrmVmhDTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EqQj+LhXy/HJqK5qflQTdS7lc9yLAalOfiG+XBv5rgM=;
	b=AHStgLwBvXL3zqcg1SknFHH7NBzjGa/K9A/4SGbZsxeYz8zzLJx2engIKoEQM0WXJU6V
	 M0BhlaHzW/raoZA1rblrwzP+7v5RTJl0PXZ9aF/GxapiSp4oHePFJ97bEXUw58eymKq2Z
	 eFyB92RhhSGWGtfeyGWAoIwWaUVNGBzYeBO/lW3/XaymzOhYFdGwZf5htd8xs8zTVP/Xf
	 xhN7qTn6SIzlb3UA604O0X29ts2ErxRScpf9/uzCPkerKUvNeV/KpETZFVBvDlVXAnZv0
	 DZNi/JClJ46y4ikaJ/DoBuP56IQvLHQ240JWEe0NuYAqA9IvBYrewfT/hkz2eWJDHRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F90J8gnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE2606A338
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F90J8gnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70341F000C9;
	Sun, 15 Nov 2026 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774872;
	bh=EqQj+LhXy/HJqK5qflQTdS7lc9yLAalOfiG+XBv5rgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F90J8gnC8Eq5vPmXRXyEAwOd0lCVJlYzY/zGcwhzULyN//yZ9xN4iVaKPxv3by8YT
	 o5sA2X6j4UTM0OOGDLaK5TzsOYQ5m6HW+7ROK3J5fuC0zuhFZFljKv2qr6JMYqxe2K
	 2imArWHhHD3iIlylo5JYgGsmcY3FRVFnCkG04KAWzZAor7tdq4SB/+v3b1R5JwUS17
	 66eXkMgSIPOYxD6HuEuNwK+SuvGQEzMnGdFX00BQ5fduG3Rr2bPA//BiW+lzGYcfqC
	 8dm4LxopjhnFMRG02VMcuh/HKCxVQ6S+nEAOmYDsJZ7Dw5gboe/oNYabrd8vX7s8W9
	 8qbm2f91yY7Jg==
Message-ID: <sashiko-outbox-215838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/27] mm/damon/api: introduce struct damon_report
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20261115202849.99134-2-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:34:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mm/damon: nonexistent fields in struct damon_report kernel-doc
  comment
--

commit 919e8293a0141a206eb1e31c857deac8b6249a6d
Author: SJ Park <sj@kernel.org>

mm/damon/api: introduce struct damon_report

This commit defines enum damon_report_type and struct damon_report to
represent data attribute reports.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 06bd92981af21..5c32ddebf4625 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -751,6 +751,29 @@ struct damon_intervals_goal {
>  	unsigned long max_sample_us;
>  };
> =20
> +/**
> + * enum damon_report_type - Type of &struct damon_report.
> + */
> +enum damon_report_type {
> +	NR_DAMON_REPORT_TYPES,
> +};
> +
> +/**
> + * struct damon_report - Data attribute report information.
> + *
> + * @type:	Type of the report.
> + * @addr_range:	The address range of the memory to report for.
> + *
> + * Note that the @start_addr and @end_adr represents an end-open range.
> + */
> +struct damon_report {
> +	enum damon_report_type type;
> +	struct damon_addr_range addr_range;

[Severity: Low]
The kernel-doc comment refers to @start_addr and @end_adr (with a typo in
"end_adr"), but struct damon_report embeds @addr_range (a struct
damon_addr_range with @start and @end fields) rather than defining those
fields directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D1
