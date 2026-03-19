Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDE274B28
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933183; cv=pass; b=kBW9rzYHp7xKqRZzgDQhmfeEvReHeXdZo8PrERYQWKIVbv5RdeS8xlsK1CtvPijv/r/MnpKQ9S+4toEfPKhpIbwXRZ9Bc+ZXquMuJ0awfSNskN0Aeg7zxJxBTHuHp7TuqUSwLomZDaDr0UZAdruSxp7UlbuXLJWFcz5bBW5QExA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933183; c=relaxed/simple;
	bh=muuNQOwicsE2lphd/y+zkw/EP/Z2DAJ4nqx6GZyORiA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oosINZ8xucDzBe0OMmpF+FT0b5olsJ2XZLBVIJjqA4+UPo1Qq3i0SeU2VNEqe6grDgP5kQRpxbHj+5rqCJIoWxb2vy6epy4itpHHXZrujNWI6lLwCb6DqvS5cuZBQKTsubNnXhSquakztDMl5IgD0duy7wCd8cPVxsW+Fp4LdRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=a66fUyLR; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="a66fUyLR"
ARC-Seal: i=1; a=rsa-sha256; t=1773933177; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Pvj757HxgJE7m1HiGxA2ozaP1gr3GNqqkfOII7RHLBdKf3kjMAuZkPkf0YcsuRiynEQ4eEJf4oNS+nc39xxfLn5DEv58pYe9JiZaaguADomzc/PrnxsHOTRipj8QpqDFA4FcXJu845TfLXMrsmkXS08pIfgnBM/X8P+sKO35+qA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773933177; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vPmnnApMywamnXXS4C3JiFUZnEyIENynnVK9tYqgVks=; 
	b=Ok93RC9nYStxyG0MCE4aex5vPjN8d3f+OLSEwbPGwLd7GyK1Ia3cZz+Nqw4+fCAvPs7XCFCe7ukF6JsBtNgs6+CsRNFaS+qizvu4aO3wdzj2aovxwW4TTR1keyQh/Qwv5uoQTdAEFsW6t4knxmOn5x3DMP/EftyR5cxsSGfcNXs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773933177;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=vPmnnApMywamnXXS4C3JiFUZnEyIENynnVK9tYqgVks=;
	b=a66fUyLRrG/VqOHfdwpJQDcPZoVN3n0L5z7VxeFkvkONYcQ+hY6NVYKeFomDvgJ3
	NSR1mvMClQN+ClCc3Pnbu16fCor+tio56tS4+a5cHBJXyGeAjrBXksrKH/HbTYqOKKi
	i5dtQ+ZY5IWDzi2XTD8UC3KouhUchoWdmMnaBsHk=
Received: by mx.zoho.eu with SMTPS id 1773933175222952.7815216944042;
	Thu, 19 Mar 2026 16:12:55 +0100 (CET)
Date: Thu, 19 Mar 2026 15:12:53 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_mm/damon/core=3A_reset_nr=5Fdests_o?=
 =?US-ASCII?Q?n_allocation_failure_in_damos=5Fcommit=5Fdests=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260319143437.82957-1-sj@kernel.org>
References:  <20260319143437.82957-1-sj@kernel.org>
Message-ID: <9E7F465D-A679-48A2-9A5B-03F674CF7ADE@objecting.org>
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



On 19 March 2026 14:34:36 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>On Thu, 19 Mar 2026 07:07:18 +0000 Josh Law <objecting@objecting=2Eorg> w=
rote:
>
>>=20
>>=20
>> On 19 March 2026 04:33:09 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>> >Hello Josh,
>> >
>> >On Wed, 18 Mar 2026 21:49:39 +0000 Josh Law <objecting@objecting=2Eorg=
> wrote:
>> >
>> >> damos_commit_dests() frees the old node_id_arr and weight_arr before
>> >> reallocating=2E  If kmalloc_array() fails, the function returns -ENO=
MEM but
>> >> leaves dst->nr_dests at its previous value=2E  A subsequent call wit=
h the
>> >> same nr_dests will skip the reallocation (the sizes match), and the =
loop
>> >> at the end will dereference the now-NULL array pointers=2E
>> >
>> >Nice catch=2E  But, this is a sort of intended behavior=2E
>> >
>> >The idea behind the code is that, if the function fails, the caller wi=
ll
>> >not resue 'dst' but discard it=2E  Hence the function is only ensuring=
 the 'dst'
>> >after the failure can be deallocated using the deallocation helper fun=
ction
>> >like 'damon_destroy_scheme()'=2E  For this, the function is setting we=
ight_arr as
>> >NULL in the allocation failure=2E
>> >
>> >>=20
>> >> Fix this by resetting dst->nr_dests to 0 immediately after freeing t=
he
>> >> old arrays, so any later call always enters the reallocation path=2E
>> >>=20
>> >> Fixes: cbc4eea4ffb5 ("mm/damon/core: commit damos->migrate_dests")
>> >> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> >> ---
>> >>  mm/damon/core=2Ec | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>=20
>> >> diff --git a/mm/damon/core=2Ec b/mm/damon/core=2Ec
>> >> index 7f74982535ac=2E=2Ee233eb84a2d5 100644
>> >> --- a/mm/damon/core=2Ec
>> >> +++ b/mm/damon/core=2Ec
>> >> @@ -1060,6 +1060,7 @@ static int damos_commit_dests(struct damos_mig=
rate_dests *dst,
>> >>  	if (dst->nr_dests !=3D src->nr_dests) {
>> >>  		kfree(dst->node_id_arr);
>> >>  		kfree(dst->weight_arr);
>> >> +		dst->nr_dests =3D 0;
>> >> =20
>> >>  		dst->node_id_arr =3D kmalloc_array(src->nr_dests,
>> >>  			sizeof(*dst->node_id_arr), GFP_KERNEL);
>> >
>> >Someone (including a part of myself) could argue anyway initializing t=
he field
>> >is better to do, for code readability and completeness of the data str=
ucture=2E
>> >But I'd argue that might only encourage calllers to reuse 'dst' after =
the
>> >failure=2E  Also, the 0 nr_dests could still meaning something incorre=
ct, if the
>> >first kmalloc_array() for node_id_arr success but the following kmallo=
c_array()
>> >for weight_arr failed=2E  In the case, nr_dests is zero, but the size =
of
>> >node_id_arr is not zero=2E
>> >
>> >I think the intention behind the code is not well documented and that =
might
>> >confused you=2E  Sorry if that was the case=2E  I think this could bet=
ter be
>> >documented by adding comments for the function=2E  The single line com=
ment in the
>> >function body was for the purpose, but having more detailed comments a=
t the top
>> >of the function may be better=2E  If you'd like to send such documenta=
tion,
>> >please do so=2E  If not, I will do that=2E  Whatever is your preferenc=
e, thank you
>> >for finding and sharing this room to improve!
>> >
>> >=2E=2E=2E And, this patch helped me finding something actually broken=
=2E  As I
>> >mentioned above, callers of damos_commit_dests() are assumed to discar=
d the
>> >'dst' when the function failed=2E  And the only caller, sysfs=2Ec, doe=
s so, except
>> >for the final commit to the running context (kdmond->damon_ctx)=2E  It=
 can result
>> >in DAMON running with the incorrect data structure, doing NULL derefer=
ence=2E
>> >Similar issue might exist for DAMON_RECLAIM and DAMON_LRU_SORT=2E  Bec=
ause those
>> >modules use only limited parameters, there might be not=2E  I will dou=
ble check
>> >and make a fix soon=2E  Again, thank you for helping me finding this i=
ssue, Josh!
>> >
>> >
>> >Thanks,
>> >SJ
>>=20
>>=20
>> Well, I guess hardening this patch is useful for then=2E=2E
>
>Agreed=2E  Maybe adding another sanity check (e=2Eg=2E, WARN_ON(dst->nr_d=
ests &&
>(!dst->weight_arr || !dst->node_id_arr), "foo")) under DAMON_DEBUG_SANITY=
 might
>make sense=2E
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Maybe merge it as-is, because warn crashes the kernel anyway and the patch=
 mitigates it=2E

V/R

Josh Law
