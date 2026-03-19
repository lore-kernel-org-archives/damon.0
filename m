Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B53DABE3
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934013; cv=pass; b=NWH/E6Gy07ojJ0GWFEGLAvsKg0KXQL9u2EDqPtDYuOdhmtTOm+Hf5dHKpjbktdKHX+ppVnwWmBWiQUg2Vffck2mkcAt1Ux99ajC6ZGrFjK0RVme98NTkJtbhmM6svCEovTUnPVc6jRv/YvJ2mXEcF985BYdXxtBFgWuKM9lMsto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934013; c=relaxed/simple;
	bh=c91egwuGPbUa89ITnAkv9Nalq6nO21mPZHyAlnru2Ds=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HOIAqkKWY8vpG6SBaxWR4LR/8XyYvjWmxBuCHUaLGKeXAnqI1z6xne2sp4ym29FTaigH2D61pzSbLr0p0iFYi1tNkHCFovjBMy2GiVjTfDUgPg8Tvv6nFFeXFEGcnaYFBOcbFUutg3w/5JZtM/TL+bAknjSf9FKHBwYDeqiirR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=ASntnKBE; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="ASntnKBE"
ARC-Seal: i=1; a=rsa-sha256; t=1773934007; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eT+WFR5pU1i4ufVby1vxETD1vvWHvvh29i3vyWyfP3ZGb/QfufO2B7/mASglRF9syX/+h2CHqsAkXkDIRaWueqK1QLj2p/nsBfYkh+fWrdjVsNGqpDzBuX41QJFZj/A9o52JXc4x/ny8TxIaeK6lCw76qaeExyt+apsAPrBWIKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773934007; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H747lVbjk5GJRNLP9W0vcB2yh4cZMTEHKBCflRyF5H4=; 
	b=QAu6wwK9AbYC7ztOw2Lzjj5Vq1HFqVlhxbTfa27+j5mNebHCzDHRoByx8zConZaUD3Zj6PL5Hhu1fFXv7UaAxk/qSOcMDYypIUBk6EjR9kAech8UAIZ7nmNoXrnYJBsWAk2wjDDsV+QcASqw+IYCqsl29xQlVop5svnttqxExns=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773934007;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=H747lVbjk5GJRNLP9W0vcB2yh4cZMTEHKBCflRyF5H4=;
	b=ASntnKBEg90anYoDtbkHthqrcCChXCV7oHSvpiIvgxjDNU8PH8o4TaKfjyzkO/Ba
	Ko2lwiVkZxHmiDwQCzLgR8zxcUKh7mOE/m0xCAuIEA1r0PtPh6U+sCouXXx151UiBUE
	33rjUtS6/dkb40AD0fYn7A5wjmg+jN0nTbcL15DM=
Received: by mx.zoho.eu with SMTPS id 1773934004932632.9143077698317;
	Thu, 19 Mar 2026 16:26:44 +0100 (CET)
Date: Thu, 19 Mar 2026 15:26:41 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/damon/core=3A_document_d?=
 =?US-ASCII?Q?amos=5Fcommit=5Fdests=28=29_failure_semantics?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260319152434.87003-1-sj@kernel.org>
References:  <20260319152434.87003-1-sj@kernel.org>
Message-ID: <490DD03E-C66A-40FD-8008-C846350252BF@objecting.org>
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



On 19 March 2026 15:24:33 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Thu, 19 Mar 2026 07:31:14 -0700 SeongJae Park <sj@kernel=2Eorg> wrote:
>
>> Hello Josh,
>>=20
>> On Thu, 19 Mar 2026 07:13:32 +0000 Josh Law <objecting@objecting=2Eorg>=
 wrote:
>[=2E=2E=2E]=20
>> And Sashiko comment [2]=2E  TL; DR: Good finding=2E  We aware the issue=
 and working
>> on the fix=2E  Nonetheless, that's out of the scope of this patch=2E
>>=20
>> : Does leaving dst in a torn-down state cause a NULL pointer dereferenc=
e in
>> : the background kdamond thread?
>[=2E=2E=2E]
>> Nice catch=2E  We actually figured out [3] this issue from the discussi=
on on
>> Josh's previous patch that motivated this one=2E  And I'm working on it=
=2E
>
>I just posted the patch:
>https://lore=2Ekernel=2Eorg/20260319145218=2E86197-1-sj@kernel=2Eorg
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Hello, this morning i found some big bugs in sysfs=2Ec, ill post the patch=
e(s) soon
