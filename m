Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0218D24DCE3
	for <damon@lists.linux.dev>; Fri, 26 Sep 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857026; cv=none; b=cQF+qDIuBR8y2ND3vQYGjSWp0fPQ8ZqmAtuNy/UUa3KDOgZNI7sOLxCwxn8rY3uoPMGdhkLtkibIgYBjkUo4/kHQwEkTW52YXs7GT+0x4aJAGV1mrwxOP4rOtpNX1l2GyEGbodRlZKDA6pHlpNNa0kgmiDHDz4O8SR8Y5HkKVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857026; c=relaxed/simple;
	bh=ms7DLBI8DUfZk/Ebjea13SSKAVpFqHGxs862qXTBDVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jI5dIi0dugYQWeho8uNZBox+xWr7r8Ck61zC8s7Vb2PbeSFKUodelkkzl68PDsi8OOBVWDamCqUKUGyqBY8oyl2elWIU+Co2ETdTO9qVfaOyWIbn9F6tEaTqZ6wBB76JvK3lOCyae9Z2McYzw3P1OgYq1LX68nS0yG12Xl0udPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 30690d089a8811f08b9f7d2eb6caa7cf-20250926
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:754cb34b-de39-45ed-9ab9-959c42735704,IP:10,
	URL:0,TC:0,Content:8,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:3
X-CID-INFO: VERSION:1.1.45,REQID:754cb34b-de39-45ed-9ab9-959c42735704,IP:10,UR
	L:0,TC:0,Content:8,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:3
X-CID-META: VersionHash:6493067,CLOUDID:6cab5c0d6cdc09a038d9058c7d077e22,BulkI
	D:2509222101471ZTQKNV7,BulkQuantity:1,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841|850,TC:nil,Content:4|50,EDM:-3,IP:-2,URL:99|1,File:nil,R
	T:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: 30690d089a8811f08b9f7d2eb6caa7cf-20250926
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 546424312; Fri, 26 Sep 2025 11:23:36 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com
Subject: Re: [RFC PATCH 0/2] DAMON: add priority-based scheme application
 control
In-Reply-To: <20250922130132.59955-1-sj@kernel.org> (SeongJae Park's message
	of "Mon, 22 Sep 2025 06:01:32 -0700")
References: <20250922130132.59955-1-sj@kernel.org>
Date: Fri, 26 Sep 2025 11:23:33 +0800
Message-ID: <87bjmxvqve.fsf@>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hello SJ,

On Mon, Sep 22 2025 at 06:01:32 AM -0700, SeongJae Park wrote:

> Hello Enze,
>
> On Mon, 22 Sep 2025 18:10:20 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> This patchset introduces a priority mechanism for DAMON's scheme
>> application, allowing users to specify the relative importance of
>> monitored processes.  The changes ensure that higher-priority targets
>> receive more frequent memory management operations while maintaining
>> fairness across all monitored processes.
>
> Thank you for this patchset.
>
> There are features for monitoring target-based DAMOS filtering
> (DAMOS_FILTER_TYPE_TARGET) and per-scheme applying time interval
> (apply_interval_us).  Couldn't those be used for your purpose?
>

Sorry for the delay.  I've been testing it for the past few days.

The combination of schemes and filters does indeed emulate a
priority-like mechanism quite effectively.  This is a fantastic feature!
It's exactly what I needed for managing my workload's priorities.

>> 
>> The first patch modifies kdamond_apply_schemes to implement
>> priority-based scheduling, where targets are processed in proportion to
>> their assigned priority values.  For example, a target with priority 50
>> will be serviced 50 times for every 30 times a target with priority 30
>> is processed.
>> 
>> The second patch adds a sysfs interface (priority under each target's
>> directory) to dynamically configure these priorities at runtime. This
>> enables fine-grained control over DAMON's behavior, making it more
>> adaptable to performance-sensitive workloads.
>> 
>> Together, these changes provide better flexibility for users who need
>> differentiated memory management policies across different processes
>> while maintaining backward compatibility with existing setups.
>> 
>> You may want to verify this feature using the following testing
>> procedure:
>> 
>>  # git clone -b v2 https://github.com/lienze/damo.git
>>  # cd damo
>>  # ./damo start --target_pid $(pidof <target1>) --priority 50 \
>>  --target_pid $(pidof <target2>) --priority 30 --damos_action \
>>  pageout --damos_age 5s 5s
>
> So I'm wondering a command like below could be used instead.
>
> $ sudo ./damo args damon \
> 	--target_pid 123 \
> 		--damos_action pageout --damos_age 5s 5s \
> 		--damos_filter allow target 0 --damos_apply_interval 3s \
> 	--target_pid 456 \
> 		--damos_action pageout --damos_age 5s 5s \
> 		--damos_filter allow target 1 --damos_apply_interval 5s \
> 	--damos_nr_filters 1 1
>
>

I've been wondering, though -- for users seeking a simpler interface,
could we allow them to define a basic priority value and let the kernel
handle the resource distribution automatically?  This would require the
DAMON system to intelligently translate a user-defined priority value
into appropriate internal operations based on current system resources.
WDYT?

Best Regards,
Enze

<...>
