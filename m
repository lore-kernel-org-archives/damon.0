Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3014F9D6
	for <damon@lists.linux.dev>; Tue,  9 Dec 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272301; cv=none; b=vBnYEYWCATZ9ub/r1CoTlq6GkCTPYcDK5jrz5OUHMUgKrD5kB2L0thuCjyNms6pN2J8g8TW9NIFoG8D+GadgsqiapFLgipq/OI0ZVQefwNBvaP68GNpdx5XbjIihJ+TnQRLh9o2iLzZpDVLAUE0IznYZvj/ZLE35ebSl8lkGKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272301; c=relaxed/simple;
	bh=ZT145ZXG+Iu649Kr8syip98Vt43BmULjEN8IC1mAAtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkfnjNRKjZ2emALLUZo4dbxfBQiwz89mf4L4JkO8scv38Qzw5g3CJJoym3wp4XlE4KafTPZ8jcoSAiH0sw+iGpNApvqb8T3KFonIC7lm+K2usjVajrMqED/CIRbpqI2tpU+YANU7Kp1UkTS0SfCo/DfJD2ylA9zoEkrn33iY12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eab46aa8d4e011f0a38c85956e01ac42-20251209
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_MISS, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:cc9d4917-cb93-4c92-ba0b-6f42ec69972c,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:cc9d4917-cb93-4c92-ba0b-6f42ec69972c,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:a9312475a3097e25d83c3277e71310d7,BulkI
	D:2512091524078HSQS3BZ,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eab46aa8d4e011f0a38c85956e01ac42-20251209
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 559780112; Tue, 09 Dec 2025 17:24:52 +0800
From: Enze Li <lienze@kylinos.cn>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org,  damon@lists.linux.dev,  linux-mm@kvack.org,
  enze.li@gmx.com, lienze@kylinos.cn
Subject: Re: [PATCH] mm/damon/core: delete damon_target when detected invalid
In-Reply-To: <20251209072146.42315-1-sj@kernel.org> (SeongJae Park's message
	of "Mon, 8 Dec 2025 23:21:45 -0800")
References: <20251209072146.42315-1-sj@kernel.org>
Date: Tue, 09 Dec 2025 17:24:49 +0800
Message-ID: <87v7igm2hq.fsf@>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi SJ,

On Mon, Dec 08 2025 at 11:21:45 PM -0800, SeongJae Park wrote:

> On Tue,  9 Dec 2025 13:57:13 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> Currently, DAMON does not proactively clean up invalid monitoring
>> targets during its runtime.  When some monitored targets exit, DAMON
>> still makes the following unnecessary function calls,
>> 
>>   --damon_for_each_target--
>>   --damon_for_each_region--
>>       damon_do_apply_schemes
>>         damos_apply_scheme
>>           damon_va_apply_scheme
>>             damos_madvise
>>               damon_get_mm
>> 
>> and it is only in the damon_get_mm() that it may finally discover that
>> the monitoring target no longer exists.
>
> Thank you for finding this inefficiency, Enze!
>
>> 
>> To avoid wasting CPU resources, this patch modifies the
>> kdamond_need_stop() logic to proactively clean up monitoring targets
>> when they are found to be invalid.
>
> However, this could introduce an unexpected behavior change to DAMON sysfs
> users.  Let's consider a DAMON context having three target processes (a, b, c)
> is running.  The second process is terminated.  And the user updates the target
> with two existing processes and a new process (a, d, c) using the online commit
> feature.
>
> Before this change, 'a' and 'c' targets keep running with the old monitoring
> results.  The target for 'b' is replaced for 'd'.  After this change, the
> target for 'b' is removed from the list, and 'c' becomes the second target of
> the list.  Because the online commit feature works based on the indices of
> targets on the list, target for 'c' is updated for 'b', lose previous
> monitoring results.

Ah, I see.  I hadn't thought of that situation.

>
> Please let me know if I'm missing something.
>
>> 
>> Signed-off-by: Enze Li <lienze@kylinos.cn>
>> ---
>>  mm/damon/core.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/damon/core.c b/mm/damon/core.c
>> index f9fc0375890a..eb5612bfd6bf 100644
>> --- a/mm/damon/core.c
>> +++ b/mm/damon/core.c
>> @@ -2462,7 +2462,8 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
>>   */
>>  static bool kdamond_need_stop(struct damon_ctx *ctx)
>>  {
>> -	struct damon_target *t;
>> +	struct damon_target *t, *next;
>> +	bool valid_target_exist = false;
>>  
>>  	if (kthread_should_stop())
>>  		return true;
>> @@ -2470,11 +2471,16 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>>  	if (!ctx->ops.target_valid)
>>  		return false;
>>  
>> -	damon_for_each_target(t, ctx) {
>> +	damon_for_each_target_safe(t, next, ctx) {
>>  		if (ctx->ops.target_valid(t))
>> -			return false;
>> +			valid_target_exist = true;
>> +		else
>> +			damon_destroy_target(t, ctx);
>>  	}
>>  
>> +	if (valid_target_exist)
>> +		return false;
>> +
>>  	return true;
>>  }
>
> So, from the beginning part of the patch description, I understand your concern
> is the unnecessary function calls in kdamond_apply_schemes().  What about
> checking the target validness using ctx->ops.target_valid() and avoid going
> deeper if it is invalid?  Seems the damon_for_each_target() loop is a good
> point to do this.
>
> What do you think?

Excellent suggestion!  Moving the validity check to the
damon_for_each_target() loop via ctx->ops.target_valid() would indeed
prevent all unnecessary function calls, which is more efficient and
architecturally cleaner than my original approach. :)

I will implement this change shortly.

By the way, I'll add a "Suggested-by" tag to the commit message, if
that's okay with you.

Best Regards,
Enze

<...>
