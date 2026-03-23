Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB453BE64A
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284505; cv=pass; b=dSXPLYDg7ZE5B6otxO17kFMjn4HANekPOShib3NNz6EuyGV90D79nzIVp0m++XNbLHpolH7YXp8Scv/sc0MDTOsFdxTuI7JZ2bv5eqW5AdJ0JWugchf5Ijuk/CtMn4ntMEMurPnDRS52DY19qesU7S8nqkZlwRPJuC03wpHgEu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284505; c=relaxed/simple;
	bh=vLkitsin3lDqtkqjZQ2znIuW91wlP+ot4ojlzdgsSug=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lolEQVT2U87S1SbO82Pfkfusd5KHMcJsNd0munuBfN4DIwtmpMb7JPMh9dPdAdIApI9fl/4vJKrouJnOF50/S3IVXlM74dMFHPR9zn3lRl0VHyhxqhCI43dKkN2mOBKE8KdkAl95COfBVSMh9K9m4smxzPZqg/WiOryXirveb7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=dLHhCDWd; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="dLHhCDWd"
ARC-Seal: i=1; a=rsa-sha256; t=1774284501; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TUr8chheOvYFMZxGGYScjnN+EsYrP5DvaQA6zT9fmDaScNNQVdiZRK/vBfaUvs9cqNYJbwsQHDAIa51x42XHo0r6/dieyC6FGfhTEl8qJFN5sG5b7GhxdAtNpSLSlfWakHQm6fLDbr54EMmkhhv6wQkiIgzVRVqTWGiVM/eDZz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774284501; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xuIcoUTBkBsZgUn7ZrvmHbUUe+AYpBylLNG6S3yEuAA=; 
	b=H5yDN/olrH2qhebEP05H5BiLoV1FT9l12HySF3PVURXVOYs+TMGUR52/XaBRYndsycr1X2VGGnvg4vWaUSKU3224yGLq8kKgxwm0pbGjszrs/kdiCCXmWJaBGSlER16Sru/n3JzEPyYl9ucv2KNlwt9lPY6epeSop/+5e5eKKm8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774284501;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xuIcoUTBkBsZgUn7ZrvmHbUUe+AYpBylLNG6S3yEuAA=;
	b=dLHhCDWdAnlY4xWHugxDQ+jhBSGVh0FCYNrqVzeP44ASiliqjtgH37/+LzTgyEs5
	Mob/sv7ZB2dCH4YT5ENVMUJ6EUy0MD6vvaHkTV5uQtePuabNnl8ceu1IKdWGL6khBgE
	6m+k7G6RBtRKWLXoMoQeDKNZdTOlPcur0QkN+WoM=
Received: by mx.zoho.eu with SMTPS id 1774284499534665.7592129103313;
	Mon, 23 Mar 2026 17:48:19 +0100 (CET)
Date: Mon, 23 Mar 2026 16:48:19 +0000
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
Message-ID: <0E185D9C-311B-47C5-AF28-06F8D1235926@objecting.org>
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



Also, unconnected to our topic!


I've tried to backport Damon to 4=2E19 (for a personal android thing, and =
failed! Of course)

Can I have a bit of help if that's fine with you? The tree is based on Git=
Hub a bit


V/R


Josh Law
