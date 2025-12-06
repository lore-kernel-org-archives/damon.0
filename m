Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B5178372
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765008257; cv=none; b=J2tU+UctjD8CVP1tQR2db+4OHZ6VexJoY31ZK+F0YiEVWJV4ANiZhJ1OhxEXlvhi6AmzwKoCP1u5Rey2ouOPdE2Pf/tCwWfISVHWtRm0b83fYXHBFipkuF34brXPiXZs1UwU0c0K30pmiVXGDLdArGMVUelhKARCfhEt7VqJTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765008257; c=relaxed/simple;
	bh=7WFAOMrQhbm4c6X3GcJ80xCvh1H23JPESjlsvIWIn7Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rIg6z8vFyK4z4NUp/Co0u7dauMKnzmwQ2+nOitL81EcFFssRFV+3I4LWb5+Ti/Om4MK1nSKSVWQJzWdj96L5LdSV9qxRDHAfH+v+XHKf3sVmpubXr0q62Pxh1YXZymHo69rm3375NgIUkyB/YmCN5mwu55uOfs1lrawgAa1+rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6703177cd27911f0a38c85956e01ac42-20251206
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:24d1c11a-0485-457b-b7ae-f774be3e8a44,IP:10,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:8
X-CID-INFO: VERSION:1.3.6,REQID:24d1c11a-0485-457b-b7ae-f774be3e8a44,IP:10,URL
	:0,TC:0,Content:3,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:8
X-CID-META: VersionHash:a9d874c,CLOUDID:f46e655ae615888f6a1a766054581a24,BulkI
	D:251206095026SCT0TVTN,BulkQuantity:2,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6703177cd27911f0a38c85956e01ac42-20251206
X-User: lienze@kylinos.cn
Received: from [192.168.3.106] [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 613505101; Sat, 06 Dec 2025 15:58:50 +0800
Message-ID: <924cfaa0-ad83-4d68-a6da-c1e8537b3232@kylinos.cn>
Date: Sat, 6 Dec 2025 15:58:45 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH v3] mm/damon/stat: deduplicate intervals_goal setup in
 damon_stat_build_ctx()
To: JaeJoon Jung <rgbi3307@gmail.com>, SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, enze.li@gmx.com
References: <20251206011716.7185-1-rgbi3307@gmail.com>
 <20251206015010.47826-1-sj@kernel.org>
 <CAHOvCC78_ci_6dg=ctt5HjgZDn4bVmNZw-qfATvShnn_7qoMaA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHOvCC78_ci_6dg=ctt5HjgZDn4bVmNZw-qfATvShnn_7qoMaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/6 12:17, JaeJoon Jung wrote:
> On Sat, 6 Dec 2025 at 10:50, SeongJae Park <sj@kernel.org> wrote:
>>
>> On Sat,  6 Dec 2025 10:17:13 +0900 JaeJoon Jung <rgbi3307@gmail.com> wrote:
>>
>>> The damon_stat_build_ctx() function sets the values of intervals_goal
>>> structure members.  These values are applied to damon_ctx in
>>> damon_set_attrs().  However, It is resetting the values that were already
>>> applied previously to the same values.  I suggest removing this code as it
>>> constitutes duplicate execution.
>>>
>>> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
>>> Reviewed-by: Enze Li <lienze@kylinos.cn>
>>
>> I show Enze did suggest changes [1] to v2 of this patch.  But I don't show Enze
>> gave Reviewed-by: tag to the patch.  Am I missing something?
> 
> I added "Reviewed-by: Enze".
> It is just minor commit message format suggestion.
> Am I putting too much emphasis on this?
> Should I delete "Reviewed-by: Enze"?

I have carefully reviewed both the commit message and the code changes
in the patch, it looks good to me.

Feel free to add,

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze

<...>
