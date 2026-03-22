Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54913184
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216031; cv=pass; b=cBHZuVaomzCVkqA+uI5Ek7/1/O4k3wbHi1KkmRLgpo8e8HaKZqs9j6RQ6MkBcIjeV0rWQa1WZr7EUKFRiI6K0WMsR/u6iNcT2i6B75SlC5ltQZRdTx7aQUVnarlBlfTEhaKWFUfxAz2CPuSskD66NKcqdJQs9bhauLskuwy568I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216031; c=relaxed/simple;
	bh=3bb1igWKLaocoEC6gZrI581gVnjmQsIEzgrfIhXnfLI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TmYZ6HFeNMvdFYCOo0lNWt9Rv4HWu+tagjYI2c5PcDS1/eJatIMvjA0cVvt67HOsDb2mmTZz/yOwEfmfNpRaLixIBk8jYgJ1v5imA23WSioOsvjNwB6IrtpUt/Ae/KwLV37t4mAtwDLlkjNHBroT8rRZ0A/NLrFRrHG4rPo9tp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=EYmLpwQv; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="EYmLpwQv"
ARC-Seal: i=1; a=rsa-sha256; t=1774216026; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aORaaBr1yeo41PxBuHQdK6K8udCh54dJoBCqmvPyoprvo0MR1jCr0dZKuhvTPn/GJyksBq8vw0+e3I67CiPn3bhugqM91cSuQ9ULtjpndotlcJ5a9g8hFopUkWBPZO0gq8qiGHl49fCLuJe15zFlFO2LnSndS+QvBTrMP240rQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774216026; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HXLmepxkAT3ih7z9DVRd6OmLc/Oq1zcUKdvohFufYtQ=; 
	b=AvUoD6Y8VVDmn15C909wcXbCUJJFbo4P/fpThfIbdny/4+xlVSERS3qUyHrbvKolVaRcJ1rGLhQihS8TkoStXsggsfjcPQQMNHGHnB9J5GY6yexVevA5GO202QBJBeMTLs7pbNEwIURfiH5LCDQZ4egfSm2IAGWrHknlJodpfKc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774216026;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=HXLmepxkAT3ih7z9DVRd6OmLc/Oq1zcUKdvohFufYtQ=;
	b=EYmLpwQvilR/nwMiiZx9YWXrFbyb7NkauJ33x63jnNKLc87W8RmjMIviXB4iNia3
	7kCbxbSJV0SYJk5cssJk2fMLRevJ1SaqEYiEGU6kMlAKxC0dicJo2Ml0sD9/aPCHDNx
	q7mHF0FE11LbkHwbLxuRcVSe3k28bBnNElY3KZ+c=
Received: by mx.zoho.eu with SMTPS id 1774216024676308.1049291411887;
	Sun, 22 Mar 2026 22:47:04 +0100 (CET)
Date: Sun, 22 Mar 2026 21:47:03 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_mm/damon/core=3A_optimize_kdamond=5Fap?=
 =?US-ASCII?Q?ply=5Fschemes=28=29_by_inverting_scheme_and_region_loops?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260322214419.89419-1-sj@kernel.org>
References:  <20260322214419.89419-1-sj@kernel.org>
Message-ID: <668B87EC-A893-433F-AC0F-412854A6F95D@objecting.org>
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



On 22 March 2026 21:44:18 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Hello Josh,
>
>On Sun, 22 Mar 2026 18:46:40 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>> Currently, kdamond_apply_schemes() iterates over all targets, then over=
 all
>> regions, and finally calls damon_do_apply_schemes() which iterates over
>> all schemes=2E This nested structure causes scheme-level invariants (su=
ch as
>> time intervals, activation status, and quota limits) to be evaluated in=
side
>> the innermost loop for every single region=2E
>>=20
>> If a scheme is inactive, has not reached its apply interval, or has alr=
eady
>> fulfilled its quota (quota->charged_sz >=3D quota->esz), the kernel sti=
ll
>> needlessly iterates through thousands of regions only to repeatedly
>> evaluate these same scheme-level conditions and continue=2E
>>=20
>> This patch inlines damon_do_apply_schemes() into kdamond_apply_schemes(=
)
>> and inverts the loop ordering=2E It now iterates over schemes on the ou=
tside,
>> and targets/regions on the inside=2E
>>=20
>> This allows the code to evaluate scheme-level limits once per scheme=2E
>> If a scheme's quota is met or it is inactive, we completely bypass the
>> O(Targets * Regions) inner loop for that scheme=2E This drastically red=
uces
>> unnecessary branching, cache thrashing, and CPU overhead in the kdamond
>> hot path=2E
>
>That makes sense in high level=2E  But, this will make a kind of behavior=
al
>difference that could be user-visible=2E  I am failing at finding a clear=
 use
>case that really depends on the old behavior=2E  But, still it feels like=
 not a
>small change to me=2E
>
>So, I'd like to be conservative to this change, unless there are good evi=
dences
>showing very clear and impactful real world benefits=2E  Can you share su=
ch
>evidences if you have?
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Hello,


Here are some benchmark results for both patches indicating the need


Benchmarking Patch 2 (Division elimination) with 1024 different attrs=2E=
=2E=2E
Old (with division): 0=2E376372 s
New (cached value): 0=2E265899 s
Speedup: 1=2E42x


Benchmarking Patch 1 (Loop inversion) with 10 schemes, 5 targets, 2000 reg=
ions=2E=2E=2E
Old (nested regions): 0=2E055627 s
New (inverted schemes): 0=2E016167 s
Speedup: 3=2E44x



