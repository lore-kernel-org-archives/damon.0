Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2636BCDB
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424188; cv=pass; b=OaGXhn+TH73wV5qX4TvZpe+UIytNKpaUSYqgbtfYdd+xXQUvZjwq+QgqNLoWSavPDeynDLUi0LduCKz64Myo4hPhoDsoCfGM6gE/f+qFK89jKdqWEqcU8k+DgCvb3VrLjOWPnjI3vl+4DSWb9VAtqRczloFxb6YmIK8mRHxbPpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424188; c=relaxed/simple;
	bh=6RM/12Cp/E1j6aUjKfSKqly5wUKqjT9Dnc3ptLKeCEw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hLoxoVPJy6clq8hPFOLFrJLj3rVmqAyDNBa4aEHvlI1WW5VjA8X8XZYdKYIaYbGTOQfClpPhwA7JtDXptIXMtdRybHQ5fj4kDNx21C/+BWbbzIM/8NfeJ9PF5iOLDoLN0O/7YnWoBtpl2gzt2jWLCwvWPQzsrygTnlyswR8r+d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=cAlP9RBE; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="cAlP9RBE"
ARC-Seal: i=1; a=rsa-sha256; t=1774424182; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eE4I+XSjwIxjR7xH/5s8KFOt7C5SlpQhkRkYW/fXSDTdRKDplD8d9CUvFTsEPB+B+nA+pC/f9CmlN7WMRYBXrchY0p3kseFBOf5UY0G8w9IXCGkBBTGy4Ihqm6B+zYMP0ox4kz8wtZWBkwdHIpPejX4aeqwPmKbryuMWeJ6U8Bo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774424182; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VtUKY5DO0st46tC4ZDWh2PAEENO7whJpWxG4Ec9CYhc=; 
	b=LrP4Ewm6BQ6LVCsZ8n/Te6p9k3inhkKWIlttMiIMaVngiwFVqI40zRWJl3JTsvNfKKgTXsIS678CnvTQNKk+K46vg5wRhllqS8CL1MMbW0mpQnU5EX5lUKPewv1T7lBHS40fmmoLJSNegbBTzo9JXsusD2R3nyeS523CwqgwV9M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774424182;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=VtUKY5DO0st46tC4ZDWh2PAEENO7whJpWxG4Ec9CYhc=;
	b=cAlP9RBEsJ1x7tezSY/N1Jaqo9Km/1RnS2SW0lq7ksRbiB1sLpgSoRpw2NQdg6av
	f2AsfY8dD0gRRjINrXlWn7d45LLLGM816iD8lIsCXnWdUre5qYismt+mVv9ybOcY3wM
	cWhQIay8ZRDM2E3xxRENtF85B88Wim9wJw7pfRWY=
Received: by mx.zoho.eu with SMTPS id 1774424179714678.2530095985786;
	Wed, 25 Mar 2026 08:36:19 +0100 (CET)
Date: Wed, 25 Mar 2026 07:36:20 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=28sashiko_review=29_=5BPATC?=
 =?US-ASCII?Q?H=5D_mm/damon/core=3A_eliminate?=
 =?US-ASCII?Q?_hot-path_integer_division?=
 =?US-ASCII?Q?_in_damon=5Fmax=5Fnr=5Faccesses=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260325011653.85502-1-sj@kernel.org>
References:  <20260325011653.85502-1-sj@kernel.org>
Message-ID: <E4E214DB-E7C0-4B69-8DC2-2A9640BF5CC6@objecting.org>
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



On 25 March 2026 01:16:52 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Forwarding Sashiko review for doing discussions via mails=2E
>
># review url: https://sashiko=2Edev/#/patchset/20260324154005=2E83651-1-o=
bjecting@objecting=2Eorg
># start of sashiko=2Edev inline review
>commit ff5e227a18cd69435749b0aae0dc2c762c4f0a47
>Author: Josh Law <objecting@objecting=2Eorg>
>
>mm/damon/core: eliminate hot-path integer division in damon_max_nr_access=
es()
>   =20
>Hardware integer division is slow=2E The function damon_max_nr_accesses()=
,
>which is called very frequently, performs an integer division=2E
>However, the struct damon_attrs already caches this exact ratio in the
>internal field aggr_samples=2E We can eliminate the hardware division in
>the hot path by simply returning aggr_samples=2E
>
>> diff --git a/include/linux/damon=2Eh b/include/linux/damon=2Eh
>> index d9a3babbafc1=2E=2E04c8a052fcfb 100644
>> --- a/include/linux/damon=2Eh
>> +++ b/include/linux/damon=2Eh
>> @@ -978,8 +978,7 @@ static inline bool damon_target_has_pid(const struc=
t damon_ctx *ctx)
>>  static inline unsigned int damon_max_nr_accesses(const struct damon_at=
trs *attrs)
>>  {
>>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
>> -	return min(attrs->aggr_interval / attrs->sample_interval,
>> -			(unsigned long)UINT_MAX);
>> +	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
>>  }
>
>If an administrator dynamically updates aggr_interval via sysfs and commi=
ts
>the inputs, will attrs->aggr_samples be correctly recalculated?
>
>If aggr_samples becomes stale, kdamond_fn() will compute the real aggrega=
tion
>loop count and allow r->nr_accesses to increment up to the new bounds (fo=
r
>example, 80 loops)=2E Meanwhile, damon_max_nr_accesses() will return the
>stale aggr_samples cache (for example, 20)=2E
>
>When evaluating schemes, damon_hot_score() normalizes r->nr_accesses agai=
nst
>this stale maximum, producing a freq_subscore that severely exceeds
>DAMON_MAX_SUBSCORE=2E This causes the calculated hotness to exceed
>DAMOS_MAX_SCORE=2E
>
>For DAMOS_PAGEOUT actions used by damon_reclaim, damon_cold_score() retur=
ns
>DAMOS_MAX_SCORE - hotness, yielding a highly negative score=2E
>
>Could this negative score cause an out-of-bounds write on the
>kernel heap when used as an array index?
>
>mm/damon/core=2Ec:damos_walk() {
>    =2E=2E=2E
>    c->regions_score_histogram[score] +=3D damon_sz_region(r);
>    =2E=2E=2E
>}
>
>> diff --git a/mm/damon/core=2Ec b/mm/damon/core=2Ec
>> index db6c67e52d2b=2E=2Eafb058f7da5c 100644
>> --- a/mm/damon/core=2Ec
>> +++ b/mm/damon/core=2Ec
>> @@ -587,6 +587,7 @@ struct damon_ctx *damon_new_ctx(void)
>>  	ctx->attrs=2Esample_interval =3D 5 * 1000;
>>  	ctx->attrs=2Eaggr_interval =3D 100 * 1000;
>>  	ctx->attrs=2Eops_update_interval =3D 60 * 1000 * 1000;
>> +	ctx->attrs=2Eaggr_samples =3D 20;
>
>Since this value is cached here, but not updated when intervals change, d=
oes
>it remain permanently stale during dynamic updates?
>
>
># end of sashiko=2Edev inline review
># review url: https://sashiko=2Edev/#/patchset/20260324154005=2E83651-1-o=
bjecting@objecting=2Eorg
>#
># hkml [1] generated a draft of this mail=2E  It can be regenerated
># using below command:
>#
>#     hkml patch sashiko_dev --for_forwarding \
>#             20260324154005=2E83651-1-objecting@objecting=2Eorg
>#
># [1] https://github=2Ecom/sjp38/hackermail
>
>Sent using hkml (https://github=2Ecom/sjp38/hackermail)



So it's nacked? Or is it just a review

V/R


Josh Law
