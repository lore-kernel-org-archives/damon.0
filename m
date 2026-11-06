Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948600;
	b=PyUD2amH9L+n1GJGTyZ2vJTbKHSZN8BLIJRPpeOpVCTVMOZoJra3oFXPkfW2UWFZFKd3
	 fhH705Ny3ZvUNQj8bSLLLWJJae8Sl4/CC4B24wERSmpvlY97KgLPy8JX50o9+JsujWVmc
	 vdG8/kcCL3aLqs37UXxo5FfDcVVKfJkrIW9w6Y+r4Ote8wpWBnk9t+0DmKol0DW15qNHI
	 bAw5Ckk+LlFHJODMp2MQY9u1nwJj9M7D2JlQDYyEgbDd0tgz2QT32Y1GR5vl6BErsM2Ft
	 VwK1gASv2O7jvKGSMjB5aF4gQI1T2edY5RnNh5iR7M91cZ3maQ4wJc/WntyNRVYa0sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948600;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mO1x09i7EnqPJXUwKJeExoIzGQZI3rHtjjcSVoEtSSw=;
	b=WKAxTnjjiS3O2oBEn7ny0e+e/IbMJMaNSsCT8lllMejH98UVxJfKcdM/nbwAPsgEbQ47
	 RQIWn0l4f3Aeoqv19UEVaKC/mhyJWwGILkAVfHlRLJMqnsdY0ZYTgELCBofgqCb9e70t/
	 7DT04arl3d2dn6N0Cp8wivXmEf6ZjXVhdJhMbIvnS/ricykq2ELT4Wgju7k6AjpvsFSdq
	 qN4TKB455bjYQs1Y5K1B90ZH0GHGBqBLuAADdq+Oe8RP2eRKwhT6XPulVElwknty2+Kcv
	 OcISOi9gIwZif0iVrHvfupHTmhY02XSKlowNFSt7J0i9PTPc/ag7/1ZfTgVft7dQvwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uiwzP25s;
	arc=none smtp.remote-ip=95.215.58.50
Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43720606A32F
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 07:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43720606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uiwzP25s
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=mO1x09i7EnqPJXUwKJeExoIzGQZI3rHtjjcSVoEtSSw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793948598; v=1; x=1794553398;
 b=uiwzP25szE8R7aqwL388yrOGTv4U7r4B7Y+aJmsOhGmpEl56nTTtuloHNeYlDagsG39M4UYY
 XetFr7qaoASJXkzEHaDo9hMiWjLXhWiSoc/Hdsj1Ki1gHf1h2PBDIQYM4H40LzPWFZJSdCg7FEh
 dxsCHwwGutxk8toJZnLqaDQc=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 54b6ffc0bb54435e;
	Fri, 06 Nov 2026 07:03:15 +0000
X-Mizu-Trace-ID: 54b6ffc0bb54435e
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 10/13] fs/coredump: convert vma_dump_size() to use vma_flags_t
Date: Fri,  6 Nov 2026 15:03:07 +0800
Message-ID: <20261106070307.51561-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-10-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-10-0d3cd15ab75f@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:31:01PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values when
>determining how much of a VMA to dump.
>
>The flags copied into struct core_vma_metadata remain legacy flags as they
>are consumed by the binfmt handlers.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
