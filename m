Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B6346A11
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948255; cv=pass; b=mC9SA90yOS9D2LgBhwOFJVQsTQWipDJnGCOio7TxAWbufhGCqXoUD3THglrzF9Qnkp+VlAVy9S0SisKidj5uMT0z9yEyxZp685gsWUT0uizOJyffKh8FE+UwRb8mo/jyCjq5MBVCkFj0klsaNTxhCRqcg1w8j/q0g1OQuoD/0Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948255; c=relaxed/simple;
	bh=Z83hJjmEGONx+bLIW6zL1tl/YVB6elLqEWPzfVxwXhY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=S0q3XYwghecYD9UvK/86qeuUC7icNJGYnEo3cHwHvarntcgAQdGickh3rip4mvtBRzv4h1QsedFlgLaSj3SDbN6dGFrcXJ+VAoMzQR+Fm4nqqCSuylrTsYDdApKMSq+7Qk2nA2MT6oxxU4VycYUVOUnmd2cSV8jjpRHWRvtPEbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=WQ8VgxRz; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="WQ8VgxRz"
ARC-Seal: i=1; a=rsa-sha256; t=1773948244; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LpXiz/tFnOLoP8QiZ2R/nq7fmTNiYGJi3qCyBCowWWMRmxUZgWjcQO51sbT/oGuA3NGf8chr2rakzPqj5GCwls3kz+XCQXeivvcSrpFr3DfmI0iL6snvGj/dqQxg8oCoYgFxmrSMpfMSOHZCzfkTOGDovynoG5LBI2STDsUz4t4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773948244; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=33NI7AQ68Fv4tWuv6cyisEGZPSwIxMJf5Ty5eJ3x0kE=; 
	b=HoX+lQPa1jdM8dBhh8GbSWhyhQnEEdImTRp/4W750SKHUw6jp9sjn9dctNn3I5VNEVysCQm0BWPTWubc+jLCi2C0FNdj8LO/ABrG2ZDVgGosHpfRz2p5F7ME3rg+Gu4RqFDYW5RbMsfH1RWFDgwOqkShmh0vUy1y3ryTM+aL4GM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773948244;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=33NI7AQ68Fv4tWuv6cyisEGZPSwIxMJf5Ty5eJ3x0kE=;
	b=WQ8VgxRzBRI4BfsQJNu0TZgSuX9R+xHb2ps7HuR8ltKXrTV8EE3e6Fc4dpXm/6hC
	KyYGK2GzBf2akrXPyKH09Cd59VoVcT+gSzkFekUJE3rw4dzz0TvBlQWaNP/DfFfcmBz
	tczEcRrWsTjy6l55y/JmxpsPSuEdtpMYBM8HIE5A=
Received: by mx.zoho.eu with SMTPS id 1773948242358679.734141052429;
	Thu, 19 Mar 2026 20:24:02 +0100 (CET)
Date: Thu, 19 Mar 2026 19:24:02 +0000
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org, akpm@linux-foundation.org
CC: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/4=5D_mm/damon/sysfs=3A_fix_res?=
 =?US-ASCII?Q?ource_leak_and_NULL_pointer_dereferences?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260319155742.186627-1-objecting@objecting.org>
References: <20260319155742.186627-1-objecting@objecting.org>
Message-ID: <73D7C494-E746-499F-9EF5-A6C7F3963302@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 19 March 2026 15:57:38 GMT, Josh Law <objecting@objecting=2Eorg> wrote:
>This series fixes a memory leak and three NULL pointer dereferences in
>the DAMON sysfs interface, all in mm/damon/sysfs=2Ec=2E
>
>Patch 1 fixes a damon_ctx leak in damon_sysfs_commit_input() when
>damon_sysfs_new_test_ctx() fails after param_ctx was already built=2E
>
>Patches 2-4 fix missing contexts->nr checks before dereferencing
>contexts_arr[0]=2E A user can trigger these by setting nr_contexts to 0
>via sysfs and then issuing commands that assume a context exists:
>
>  - Patch 2: CLEAR_SCHEMES_TRIED_REGIONS handler in damon_sysfs_handle_cm=
d()
>  - Patch 3: damon_sysfs_update_schemes_tried_regions(), reached via
>    UPDATE_SCHEMES_TRIED_BYTES and UPDATE_SCHEMES_TRIED_REGIONS
>  - Patch 4: damon_sysfs_repeat_call_fn(), reachable when nr_contexts is
>    set to 0 while DAMON is running
>
>Josh Law (4):
>  mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx()
>    failure
>  mm/damon/sysfs: check contexts->nr before clear_schemes_tried_regions
>  mm/damon/sysfs: check contexts->nr in update_schemes_tried_regions
>  mm/damon/sysfs: check contexts->nr in repeat_call_fn
>
> mm/damon/sysfs=2Ec | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>


[0] <https://sashiko=2Edev/#/patchset/20260319155742=2E186627-1-objecting%=
40objecting=2Eorg>



I don't think this is right=2E Probably best you don't listen to that=2E=
=2E

V/R


Josh Law
