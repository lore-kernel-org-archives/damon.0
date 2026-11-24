Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522704;
	b=kvHKNoZoQQxhmIJeyoqtdZa8FX/MZ1WGJKfin5EyKsfz1t/M06wnDWcvnvU/+YrWWoGC
	 MCOi2gm5mP/hwDCXX1t36Y0mNLQNTMLBgmT4GNHncPDlIwWsil4hSR7dCZqzKvBBJ7y97
	 bWG5j/tCmAtATTGW8Jm8cEyC5Txd8ToUEFoRVkxKNnZDDzRANG51Kqd7S051SsWKMPgMA
	 mEDugsyw2j37WQVkTb5mE0kFXRAZGV03YPj7sYJg54MEQu+vAzEHdr9V3EgSD37GtpQ0v
	 lkiFksySGa+jZXB7Ku7N1qwfhISdM9MUrDuDdDHP+FOdBaOzYKOJiUAG5xmEe+SD9sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522704;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OUGXnl29oqUu50SqEIurEsM4e0cyju2OZ81JkZSaKRk=;
	b=Q+p1AFD3XoMHC/44fZ+zCUg/OJ5TMPzwv+h/dOysZQrs7a3WEzVivoXyilWPWjmXhd2b
	 sQ2vY6gymK7b3jQg224yFZ9yIiCmIa4CJs5yfRv43tPHV3BJLHnX4oeMyXD8jawqcHNCj
	 J5wBkkQtvo+yVBuVUO3Xlhb2xyFVL7XiKR7RZvzsoyNX+WORQyu9dfaKInLNIIQXUG21o
	 OBC8rJ851OFsWZWt/gXRdkpcrOeUYGImRn7+4MZhSpFVlAzXiTUHzsigN1AVZadSgSHn0
	 xw5TGnQzdJ9jmEpBQjXp5jcihHXtU4tsNsqpdRGAhtUVFH0/DUbyQ7WBuJhM6hzjhSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T5ZFw6v8;
	arc=none smtp.remote-ip=91.218.175.252
Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAD606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 12:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDAD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T5ZFw6v8
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ehJyS5om/OyXbT78ohfS4FBoNaPuj5iCwpL3QhfmKIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795522702; v=1; x=1796127502;
 b=T5ZFw6v8wsEa7QywSdH65t93/gWh9DH9CgfPtP+4oziIND3nQ3zrdrr4MNNbBQoPlJs1p1s4
 Ud+ohf5cCk6WfCdKVIuTSAoslrEqUayzgZCQhNX28juHtUip6jzijvY7GcluP3vhggBj2CbSAQL
 NtwlcFSkEMhL4I9DJxWe85Yo=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c9fbbaba589b1890;
	Tue, 24 Nov 2026 12:18:21 +0000
X-Mizu-Trace-ID: c9fbbaba589b1890
X-Migadu-Flow: FLOW_OUT
Message-ID: <1739306a-9fa7-403c-a2da-b44f623b9445@linux.dev>
Date: Tue, 24 Nov 2026 20:18:19 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Enze Li <enze.li@linux.dev>
Subject: Re: [PATCH] mm/damon/sysfs: skip registration if DAMON core init
 fails
To: Aveline Noir <jm5905938@gmail.com>, SJ Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lian Wang <lianux.mm@gmail.com>, Dawei Li <set_pte_at@outlook.com>,
 damon@lists.linux.dev, linux-mm@kvack.org
References: <20261123-damon-sysfs-init-guard-v1-1-a2a6ca65693a@gmail.com>
Content-Language: en-US
In-Reply-To: <20261123-damon-sysfs-init-guard-v1-1-a2a6ca65693a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aveline,

On 11/23/26 15:51, Aveline Noir wrote:
> Hi SJ,
> 
> Here's the sysfs fix I mentioned in the report queue review.
> 
> -- >8 --
> 
> While reviewing the DAMON report queue series, I noticed that DAMON
> sysfs still registers its interface if DAMON core initialization fails.
> If damon_init() fails to allocate damon_region_cache, starting a
> kdamond with an initial region can pass a NULL cache to
> kmem_cache_alloc() via damon_new_region().
> 
> Check damon_initialized() before creating the DAMON sysfs directory and
> return -ENOMEM if the core is unavailable.
> 
> Fixes: a18709442869 ("mm/damon: improve damon_new_region strategy")
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> Tests passed in x86-64 QEMU TCG guests on 9f004372ebeb.

I gave this patch a try and it works.

I forced damon_init() to fail with the following modification on an 
x86_64 VM,

8<------------------------------------------------------
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 986404b547eb..194b30731572 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4313,6 +4313,10 @@ bool damon_initialized(void)
  static int __init damon_init(void)
  {
         damon_region_cache = KMEM_CACHE(damon_region, 0);
+       if (damon_region_cache) {
+               kmem_cache_destroy(damon_region_cache);
+               damon_region_cache = NULL;
+       }
         if (unlikely(!damon_region_cache)) {
                 pr_err("creating damon_region_cache fails\n");
                 return -ENOMEM;
------------------------------------------------------>8

then ran `damo start paddr --regions 0-10000`.  On the unpatched kernel 
that immediately Oops,

8<------------------------------------------------------
[  461.012857] BUG: kernel NULL pointer dereference, address: 
000000000000001c
[  461.012881] #PF: supervisor read access in kernel mode
[  461.012891] #PF: error_code(0x0000) - not-present page
[  461.012901] PGD 139e4f067 P4D 139e4f067 PUD 124048067 PMD 0
[  461.012913] Oops: Oops: 0000 [#1] SMP NOPTI
[  461.012924] CPU: 3 UID: 0 PID: 1610 Comm: python3 Tainted: G   E 
  7.4.0-rc3-new+ #2 PREEMPT(lazy)
[  461.012938] Tainted: [E]=UNSIGNED_MODULE
[  461.012945] Hardware name: Red Hat KVM, BIOS 
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[  461.012956] RIP: 0010:kmem_cache_alloc_noprof+0x16/0x400
[  461.013083] Call Trace:
[  461.013088]  <TASK>
[  461.013094]  damon_new_region+0x22/0x60
[  461.013104]  damon_set_regions+0x38a/0x4e0
[  461.013112]  ? damon_sysfs_build_ctx+0x32c/0x400
[  461.013123]  damon_sysfs_build_ctx+0x391/0x400
[  461.013133]  state_store+0x30e/0x3f0
[  461.013141]  ? __kmalloc_noprof+0x292/0x590
[  461.013151]  kernfs_fop_write_iter+0x14a/0x200
[  461.013160]  vfs_write+0x25d/0x440
[  461.013170]  ksys_write+0x6b/0xe0
[  461.013178]  do_syscall_64+0xc4/0x570
[  461.013188]  ? __x64_sys_close+0x3d/0x80
[  461.013196]  ? do_syscall_64+0x101/0x570
[  461.013205]  ? do_syscall_64+0x101/0x570
[  461.013213]  ? do_syscall_64+0x35/0x570
[  461.013221]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  461.013230] RIP: 0033:0x7fbdeba26a02
------------------------------------------------------>8

With your patch, /sys/kernel/mm/damon/ simply doesn't show up when core 
init fails, and the same damo command just errors out.  No Oops, no NULL
deref in dmesg.  That's exactly the behaviour we want.

Feel free to add:

Tested-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
