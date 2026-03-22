Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847817B505
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215154; cv=pass; b=pRtwdLmSFLJbYyjenBceUeCosAGh8nt7k3nDL7oFgISBAnYPYGI2b2x4bU1VKqzfYMnr4eAnS1g9ybEzx/hJiFWAwLHfYQz4WfAvWK9BZr8mq4t2RewU4ZuKQAIB9WOEcpsyURuxhTr0W5oa/q/u0YEsTZKwWuQ8BY4J9ckh99Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215154; c=relaxed/simple;
	bh=MG3fw1tS0nGFz3j7/1lnSbsA5BkwpH0GZm9WmcLoMdk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Jul1jT2TkZ1ZtLv/HzEJuhlJvJDnNOlHuw6xrWlspr8x9ESHqY1fyt5g3F4uYnehfZkrM7wB8dlo8ysYiBWX6o2is00KlHMXzGfgGFIF4YIWQ7MPwFqykptlNRALl6KIYg43N13scMWLe1qFyJIx7qGGvuu2hmjaUVzcas/8QtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=kykmHEEO; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="kykmHEEO"
ARC-Seal: i=1; a=rsa-sha256; t=1774215148; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dAAwTcEtXVznBzEBXgLetog4yhc7R9MkvETetVFJ6gfUmsSd5Qgi+hYduufHrlO//Z1kZ6/4BsNJBcHBUX7FWveEJaFRvkLz9LOua8n0vvkl38+gXuIDgf9SRYOmD3M6l31XanOubeLbGciWWzg1wvGMRI4TI+Jl/CY4d7t9kEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215148; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9gj+dzsGVi7TSx5K4xQwq2AxIni5W2zhxGVIg45hd5A=; 
	b=KfRi4TNlx2mKPyYQL9YVsz8haOEjykGYe5qnO1blKRfs2kNYj23WUe1tZvBpV2Fl30+YGxg2f0Alrv2jof57WBfBeZ4wkYgTA/F8HJB5S4fPOVaoUtmnQCKLiMl9IPr3xPauc5tgOxXk19gQw5Ry3d7VTaHt4ppipCWoNp5oLBY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215148;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=9gj+dzsGVi7TSx5K4xQwq2AxIni5W2zhxGVIg45hd5A=;
	b=kykmHEEOV5XO3RHDGrJX1O6zlUNgo+u55t8bHs8a00ajGnQoEoMcb2jhL49SJwtf
	I1PMsjphPrqkgn9v68v6pXFXpdZ5RWCsJkFxlJYA/t1AEEFRFn3uW/3EBg8pwDgL2Wa
	JftcFSXbslAea9JoO96vGb6bX7rtenTyldxkVrsw=
Received: by mx.zoho.eu with SMTPS id 1774215145632161.1866233750835;
	Sun, 22 Mar 2026 22:32:25 +0100 (CET)
Date: Sun, 22 Mar 2026 21:32:24 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_mm/damon/core=3A_eliminate_hot-p?=
 =?US-ASCII?Q?ath_integer_division_in_damon=5Fmax=5Fnr=5Faccesses=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260322213015.89161-1-sj@kernel.org>
References:  <20260322213015.89161-1-sj@kernel.org>
Message-ID: <E7EBB8C3-3AC1-46BD-BE5B-E4C2A6080D2D@objecting.org>
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



On 22 March 2026 21:30:15 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Sun, 22 Mar 2026 18:46:41 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>> Hardware integer division is slow=2E The function damon_max_nr_accesses=
(),
>> which is called very frequently (e=2Eg=2E, once per region per sample
>> interval inside damon_update_region_access_rate), performs an integer
>> division: attrs->aggr_interval / attrs->sample_interval=2E
>>=20
>> However, the struct damon_attrs already caches this exact ratio in the
>> internal field aggr_samples (since earlier commits)=2E We can eliminate
>> the hardware division in the hot path by simply returning aggr_samples=
=2E
>>=20
>> This significantly reduces the CPU cycle overhead of updating the acces=
s
>> rates for thousands of regions=2E
>>=20
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>>  include/linux/damon=2Eh | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>=20
>> diff --git a/include/linux/damon=2Eh b/include/linux/damon=2Eh
>> index 6bd71546f7b2=2E=2Efffdb08326a2 100644
>> --- a/include/linux/damon=2Eh
>> +++ b/include/linux/damon=2Eh
>> @@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struc=
t damon_ctx *ctx)
>>  static inline unsigned int damon_max_nr_accesses(const struct damon_at=
trs *attrs)
>>  {
>>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
>> -	return min(attrs->aggr_interval / attrs->sample_interval,
>> -			(unsigned long)UINT_MAX);
>> +	return min(attrs->aggr_samples, (unsigned long)UINT_MAX);
>
>checkpatch gives below warning:
>
>WARNING: min() should probably be min_t(unsigned long, attrs->aggr_sample=
s, UINT_MAX)
>#39: FILE: include/linux/damon=2Eh:963:
>+       return min(attrs->aggr_samples, (unsigned long)UINT_MAX);
>
>Can we use min_t() as suggested?
>
>Otherwise, this patch looks good to me=2E
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


On it!

V/R

Josh Law
