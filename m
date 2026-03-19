Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAD2FF643
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904048; cv=pass; b=o0vdOv4RaKYRo4m4I3F1Oa4pudJE6L9cSUhVWXBRKSCa4Tb4tU/qbc9ViWfyApkAPnrN+qs8dJ/hB2ygiqP9t91mAetpEZ9N9VcfZl7URsPXUSEUD8QQ+tp5SszyIab+WvRXRoOD82J2hmReKAhgq5yAKzw2SuUGhiW/qG32qIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904048; c=relaxed/simple;
	bh=d9NW8EpxKmfDHqdDti/DG9srQ0d4tVrb7ygSY0YmgDc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ys9oosPll/VzOnz5PlKbr6LvnH0oRaS8d0CnNyqdSLg2t6Lx7dDP+H7SgdvbNcoYKSbPjpRsaXrlUiJGkXjEfSprjJvR73v3sSg83D33LZpfQBJDHFhgjqej2wjvnXhPF1wuqGSYJibpvPeYNZ7A0e+dYoSiklBG9olsmIgzhgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fskvIZ97; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fskvIZ97"
ARC-Seal: i=1; a=rsa-sha256; t=1773904042; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=e9ZNPiNMOo68Qkxam/C8cay3EsA7VGGltAnosDmkJEaK8Kjo3HpDTYEHw+TdsM4AKzMzPXn2nCLfgEwFM6U0q7S12A5b3ZUO2DBCM3JtfJ55e18wXncraJvPPHcK4rFxJ5w6nGxOiZvMuFLZjYLxDvyF6zGlR0gjhYPOpy07pF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773904042; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KstVXAu8s91wD1tzpSpjUCtaNtaqVzzDqrlbR2gPxhg=; 
	b=lSaqE6xk21yiR9BjYqMC8A0/Ylg5iIYDucA5u0e98GVT7CJR1FMXYKuDaWupi8+1qL/OtXprMtx5YtZVLyBBKBvSwEfLK5CraMk1N8JqE6issYdiMidgJ25QrZhnnXkVjLh5CChHu25mZ7cYsI6yjeJGKw/dxliDWj19VI+7zuw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773904042;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=KstVXAu8s91wD1tzpSpjUCtaNtaqVzzDqrlbR2gPxhg=;
	b=fskvIZ97/1BmLA5jpR5+dGchmAJqsjqdLNmyRNH/HfLIILLSV4evG0s+E4tmC5xB
	BAaxIthu9mZ0Mlyo1c2ZzpKAE6rNCU0E0/4LSp/RI12G0UpDW+r+8plHk+chNFiX+wB
	spKt6C7UGoNZxeykFGFug9wBy4u/rKdXVi36jsPI=
Received: by mx.zoho.eu with SMTPS id 1773904038826234.8226502046814;
	Thu, 19 Mar 2026 08:07:18 +0100 (CET)
Date: Thu, 19 Mar 2026 07:07:18 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/damon/core=3A_reset_nr=5Fdests_o?=
 =?US-ASCII?Q?n_allocation_failure_in_damos=5Fcommit=5Fdests=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260319043309.97966-1-sj@kernel.org>
References:  <20260319043309.97966-1-sj@kernel.org>
Message-ID: <B08CB6C4-72EE-48AD-9AA5-16CDA175B193@objecting.org>
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



On 19 March 2026 04:33:09 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Hello Josh,
>
>On Wed, 18 Mar 2026 21:49:39 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>> damos_commit_dests() frees the old node_id_arr and weight_arr before
>> reallocating=2E  If kmalloc_array() fails, the function returns -ENOMEM=
 but
>> leaves dst->nr_dests at its previous value=2E  A subsequent call with t=
he
>> same nr_dests will skip the reallocation (the sizes match), and the loo=
p
>> at the end will dereference the now-NULL array pointers=2E
>
>Nice catch=2E  But, this is a sort of intended behavior=2E
>
>The idea behind the code is that, if the function fails, the caller will
>not resue 'dst' but discard it=2E  Hence the function is only ensuring th=
e 'dst'
>after the failure can be deallocated using the deallocation helper functi=
on
>like 'damon_destroy_scheme()'=2E  For this, the function is setting weigh=
t_arr as
>NULL in the allocation failure=2E
>
>>=20
>> Fix this by resetting dst->nr_dests to 0 immediately after freeing the
>> old arrays, so any later call always enters the reallocation path=2E
>>=20
>> Fixes: cbc4eea4ffb5 ("mm/damon/core: commit damos->migrate_dests")
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>>  mm/damon/core=2Ec | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/mm/damon/core=2Ec b/mm/damon/core=2Ec
>> index 7f74982535ac=2E=2Ee233eb84a2d5 100644
>> --- a/mm/damon/core=2Ec
>> +++ b/mm/damon/core=2Ec
>> @@ -1060,6 +1060,7 @@ static int damos_commit_dests(struct damos_migrat=
e_dests *dst,
>>  	if (dst->nr_dests !=3D src->nr_dests) {
>>  		kfree(dst->node_id_arr);
>>  		kfree(dst->weight_arr);
>> +		dst->nr_dests =3D 0;
>> =20
>>  		dst->node_id_arr =3D kmalloc_array(src->nr_dests,
>>  			sizeof(*dst->node_id_arr), GFP_KERNEL);
>
>Someone (including a part of myself) could argue anyway initializing the =
field
>is better to do, for code readability and completeness of the data struct=
ure=2E
>But I'd argue that might only encourage calllers to reuse 'dst' after the
>failure=2E  Also, the 0 nr_dests could still meaning something incorrect,=
 if the
>first kmalloc_array() for node_id_arr success but the following kmalloc_a=
rray()
>for weight_arr failed=2E  In the case, nr_dests is zero, but the size of
>node_id_arr is not zero=2E
>
>I think the intention behind the code is not well documented and that mig=
ht
>confused you=2E  Sorry if that was the case=2E  I think this could better=
 be
>documented by adding comments for the function=2E  The single line commen=
t in the
>function body was for the purpose, but having more detailed comments at t=
he top
>of the function may be better=2E  If you'd like to send such documentatio=
n,
>please do so=2E  If not, I will do that=2E  Whatever is your preference, =
thank you
>for finding and sharing this room to improve!
>
>=2E=2E=2E And, this patch helped me finding something actually broken=2E =
 As I
>mentioned above, callers of damos_commit_dests() are assumed to discard t=
he
>'dst' when the function failed=2E  And the only caller, sysfs=2Ec, does s=
o, except
>for the final commit to the running context (kdmond->damon_ctx)=2E  It ca=
n result
>in DAMON running with the incorrect data structure, doing NULL dereferenc=
e=2E
>Similar issue might exist for DAMON_RECLAIM and DAMON_LRU_SORT=2E  Becaus=
e those
>modules use only limited parameters, there might be not=2E  I will double=
 check
>and make a fix soon=2E  Again, thank you for helping me finding this issu=
e, Josh!
>
>
>Thanks,
>SJ


Well, I guess hardening this patch is useful for then=2E=2E


V/R


Josh Law
