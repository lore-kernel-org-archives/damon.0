Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAA283C82
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280941; cv=pass; b=CRoiMTCqbqti4Oj9fZ34y+dp/ynhDXhcxjdMudVUZEXgCYlcqY/pxe9a3i7rQOIXBd1w5TW6bT81WP32ijV20Hsx75V+AdFaoGwKmcB4+E/ijGet87RoBIArtzIldEw6mAfL3PvM3EIwS1w2/TV+8/PY4W26TqYlA5U2mwnjMXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280941; c=relaxed/simple;
	bh=MNBbzdy1wv3q1CYXJr0qV0f8cJFDu0KPsiy5VWDC70s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MdUlcS0MZle1mdNKZpp01OI3/BB7AeNuEYW+ljH5pSoVOf4YVx6psg3oi5z15g9+mnKcZAfX1xJZBG1mDuRB5vAuhmBpXrBvitDp2rdsGreGnfJQEIiuqM8KxJS6S1Ew2JOIcxU5U0zHmV65zFvTGO8O6Y2YVszgzNXDI9tB2dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=h1ep4pQX; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="h1ep4pQX"
ARC-Seal: i=1; a=rsa-sha256; t=1774280935; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CbbjtYdP4E/xtQsdx3+okOUtXQbDc1SOiN2xE5WVEx3gtwbaHTWnmiUI+O+Bu0YGcE62s7SdpU31AwicDgN48WX2m/VJL4HNVJCzEzyS+mxo50jZFFf4CTWqpVivGNjggjiessfXPh8E8z9Frl3k50miXdngG5kC+3evfp+yn/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774280935; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wqFlklrlq8f8GMqCaRA6JQDMLtlxicYYgk8CIa7235M=; 
	b=Lr8dxg6nZ+YV+G76OS6FVPIFay0DIb7cR4jWx7rnCHdWTRsVnLRACWjziBMldZS9hLmDcsHzVBfZGUXlOEHaArtg0ZsZ/OHdN1dfc964cvIOTKXeW6UtcqBU3I827jgKmbiIllpIPQ3UTQLcuwecNlNEKNiLis01eyyiovJltOk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774280935;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=wqFlklrlq8f8GMqCaRA6JQDMLtlxicYYgk8CIa7235M=;
	b=h1ep4pQXMZO6jnepVRwIj5Sq2N/4vnOJYX3HjjR0lvSgWDXwhiY+ZFeK+S4tLFFD
	HKf32O7YMlbpCS+Flqlrzraez6QkbbpSJdbL+MbFy8dzhR93yHbHgQIm56slZABrghd
	kOVHal1wxL0CJscvM9ZNVZMDVXGBl6qO1BCgibEQ=
Received: by mx.zoho.eu with SMTPS id 1774280932246117.62916547273733;
	Mon, 23 Mar 2026 16:48:52 +0100 (CET)
Date: Mon, 23 Mar 2026 15:48:52 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
CC: damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bv3_1/3=5D_mm/damon/sysfs=3A_fix_param=5Fctx?=
 =?US-ASCII?Q?_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260323152453.81603-1-sj@kernel.org>
References:  <20260323152453.81603-1-sj@kernel.org>
Message-ID: <96C00873-532D-4108-8FAC-80BAEB5D503F@objecting.org>
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



On 23 March 2026 15:24:52 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Mon, 23 Mar 2026 09:25:52 +0100 Markus Elfring <Markus=2EElfring@web=
=2Ede> wrote:
>
>> > Markus these patches are already merged
>
>It's still in mm-hotfixes-unstable=2E  We can still make changes if neede=
d=2E
>
>I understand what Markus is suggesting is adding another goto label to ma=
ke
>the flow cleaner=2E  Because this is a hotfix that aims to be also applie=
d to
>stable kernels, I think the change is better to be as simple as possible=
=2E
>Adding another goto label could make it better, but I'm concerned if it w=
ill
>make porting difficult=2E
>
>IMHO, it is better to do that as a followup cleanup, rather than make cha=
nge
>into the hotfix=2E  Let me know if this change is somewhat critical and I=
'm
>missing that=2E
>
>>=20
>> Are there still development interests for the application of a better g=
oto chain?
>
>Sure, if it makes it better, why not? :)
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Yeah, I understand where he's going with this, but I'll possibly make clea=
nup patches soon

V/R


Josh Law
