Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C53451D7
	for <damon@lists.linux.dev>; Mon, 15 Dec 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808402; cv=none; b=MRyQGAMscY60CE6e6jcsBOb9KZJPXyfDi2PHOmIK6AUTcLYWxGO4+MrMdVw6NfS23l0piFYFgYugrszD3gUqvlHPx+Gx9x6hiD1NS5TaKRh7AT8xwsTKi5Azg7isfU8+tMcTMyHlxIdSHOrX2EQqWjXlmX0oY2CV0+o67VlwG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808402; c=relaxed/simple;
	bh=muSSbvLZBmk9pqzv5oq1mnsnPGPgGcm/OBnvkeQ9sCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhxFvZsvpk9rLLSboX/4MrY9ubh2/z3QWJXBLJHmZJZBwBXboOsXNIvhSty+cyTMvLsWS3HMhm12SiKRzEzx4fW8HF4Gyadtf47qV+lkldmuUFTKZ7wC/VwDGi0zvOkLH6xf6ywl0dKGw0zAwL+c+ErLe53wj1+UkTOIuwDCbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d6263d0d9c111f0a38c85956e01ac42-20251215
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dc04beda-5203-40b5-b43f-f1ba260bfba1,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:dc04beda-5203-40b5-b43f-f1ba260bfba1,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:c48fc8d29e45d7aeddde6f1fb5a8a4da,BulkI
	D:2512120555166V56SJ2P,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d6263d0d9c111f0a38c85956e01ac42-20251215
X-User: lienze@kylinos.cn
Received: from [192.168.3.106] [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2023791574; Mon, 15 Dec 2025 22:19:49 +0800
Message-ID: <a14163a9-0553-4baa-8887-4e7203014887@kylinos.cn>
Date: Mon, 15 Dec 2025 22:19:45 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon: add loadable module support for sample modules
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
 enze.li@gmx.com, Christoph Hellwig <hch@infradead.org>
References: <20251211215504.79014-1-sj@kernel.org>
Content-Language: en-US
From: Enze Li <lienze@kylinos.cn>
In-Reply-To: <20251211215504.79014-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/12/12 05:55, SeongJae Park wrote:
> + Christoph
> 
> On Thu, 11 Dec 2025 20:56:14 +0800 Enze Li <lienze@kylinos.cn> wrote:
> 
>> This patch adds loadable kernel module compilation support for the three
>> DAMON sample modules.  While preserving the existing built-in compilation
>> option, the change introduces necessary code exports and configuration
>> updates, enabling these modules to also be built as independent loadable
>> modules.
>>
>> Key modifications include exporting required function symbols from
>> damon/core.c and changing relevant Kconfig options from bool to
>> tristate.  This allows users to select between "built-in", "module", and
>> "disabled" configurations.
>>
>> This enhancement provides greater flexibility for both development and
>> deployment.  Users can now compile the sample modules as loadable
>> modules and manage them dynamically at runtime without reconfiguration
>> or system reboots.
> 
> Thank you for this patch, Enze.  Actually we tried to make the modules
> loadable, but there was an objection [1] with kind clarification from
> Christoph.  In short, we don't want to make DAMON supports loadable modules
> unless there is a real use case in tree.  Samples are supposed to be samples,
> not real usages.

Hmm...  Fair enough.

> Do you have a real use case of the sample modules that require loadability?

Yeah.  Just finished preparing a patchset -- will send it to the
damon@list in a moment.

Thanks,
Enze

<...>

