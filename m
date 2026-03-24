Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C77434676D
	for <damon@lists.linux.dev>; Tue, 24 Mar 2026 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336005; cv=pass; b=MnMlLOni3urIEEQE02M1H3DeB8vElcKQSHK+X4MjH7Je0uXluo4zXRh+66M/mWYLlyk5SfAJXF7itpb2O3uD4fF4Jf0FRjPXuhEsge9jFCLslPctH6Zodcldx8revBnu37o3b+Rm7C8bEKIiXHltWs936grj+J/XfF/u8wGwD/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336005; c=relaxed/simple;
	bh=n3eCsBEH4u1wHa8dJtfVWcL6OZPHobfR/MYjrVJcIW4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=I8i9ZUwR/6KEGiMqdd77gfUCmM3nOTR2JMS18eJHmIgyC8lVhtTiER7ggvZKxdBLgR0ewgCm9sHNa9mFvmh0pua038DnSDJnC+Mx10tOlrBhAJgTRwkhu6KMUq+XL1huJ++456qUoweX3N1gvDGTDvOJh2aIfsTtMzW/dxWin4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=EZ+Z4NWc; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="EZ+Z4NWc"
ARC-Seal: i=1; a=rsa-sha256; t=1774335991; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jP/cJdvUKvWgGl/m66OGGlqy6OEfSYEOQ6MikmzEG60N74+qBkVQL5WCMDbkNUEUeeT6OUnREnz6NIwTWXjToWnV2Be5ig04wmGNyqc23yA1WoXDHlshJ0kJEu7T8nihVRyqnUiAePqS+P2d665GHXPwuUVTAn0prfPqGyITsIM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774335991; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lP8i3Qty/bHUVvaH5kVoGQLcodg/p/1/bywjT4dTNhc=; 
	b=QHhZ0F6QgC332Y3owawq5SWJ71rg+kUZ+D4KA3EgvZsRAG0CYkwU3gDmlHKgw55xvAkIp1I0Z/2wyKzdJNY/h7Xmi9wG3Yf+7HOoVuvZeJ+q0fL6as18KiTTrLqCXGBoz51Nz55KxeWX+18aY7o/Ez7CQIZPZr54DS4XtERqMwg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774335991;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=lP8i3Qty/bHUVvaH5kVoGQLcodg/p/1/bywjT4dTNhc=;
	b=EZ+Z4NWcp/pKJ7ARgcaqRUM6MeQieW6LmvEcOefoceBW8HKO9RcHPVoC69tlaxMt
	uJxNNJMBRrt29IZuW5itXs3g9+CZGXyGiLfnwk4jz9qt6Wl9Ra5zV3bVczlKxbsGWnJ
	j82sSwkTnUinqup1sT+0dMwIuicEA0jr+M6lxqes=
Received: by mx.zoho.eu with SMTPS id 1774335988821909.6110963179683;
	Tue, 24 Mar 2026 08:06:28 +0100 (CET)
Date: Tue, 24 Mar 2026 07:06:25 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Markus Elfring <Markus.Elfring@web.de>, damon@lists.linux.dev,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bv3_1/3=5D_mm/damon/sysfs=3A_fix_param=5Fctx?=
 =?US-ASCII?Q?_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260324001500.86247-1-sj@kernel.org>
References:  <20260324001500.86247-1-sj@kernel.org>
Message-ID: <A0701CEF-CDF1-4B3E-B25A-C05A32AE822C@objecting.org>
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



On 24 March 2026 00:14:59 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Mon, 23 Mar 2026 16:48:19 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>[=2E=2E=2E]
>> Also, unconnected to our topic!
>>=20
>>=20
>> I've tried to backport Damon to 4=2E19 (for a personal android thing, a=
nd failed! Of course)
>>=20
>> Can I have a bit of help if that's fine with you? The tree is based on =
GitHub a bit
>
>Sure, I will be happy to help as much as I can without burning myself ;)
>
>Seems [1] Alma Linux has backported DAMON on their 4=2E18 kernel=2E  Mayb=
e you can
>try their port first?
>
>Also, what is the oldest kernel that you have to use?  As newer it is, th=
e
>backporting will be easier=2E  When I was in AWS, I backported DAMON of v=
6=2E7 on
>the v5=2E10 based Amazon Linux kernel, and the source is available on Git=
Hub=2E  So
>if you can use 5=2E10 based kernel, using that could also be a good optio=
n=2E
>
>[1] https://oracle=2Egithub=2Eio/kconfigs/?config=3DUTS_RELEASE&config=3D=
DAMON
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]



well android likes using old kernels for some reasons, especially LTS, so =
4=2E19=2E=2E

V/R


Josh Law
