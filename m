Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945395;
	b=yNZbJQ9/2eQGdGc5NEIX+Sb328nB6ue6sl1fFtD4kVgvKsqszxBk1Z4vmIoJ97yAQ56P
	 JoZix+o9M+3CT5fb8E4cVluXM1jn3bwpPfTlKT005+noN5839AJ6VlH0QK2ZKlaKOBoGe
	 WybW2gCHX8z3H3U4L9A5ikS0NhqJVf0IjNol+3rtnedSEXborFRN+ARc4KRR1nMBaP8Lh
	 l/PIuDriRZXrh0Bpa+0Wwt4uMc7P0qgHCEuA6euHk7DVYoMRq/tPN48zRuj4nNlz+8o7r
	 0sZEQXQ8R7aSYXmzB6w23M6eCaXUtILl/4wyEqmV2wdKzZmOVo+pN13C0e3XT4ioy6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945395;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lf0giC54COfoOdgBhV+lbp71w6egVz2uLYQE0MSpLfQ=;
	b=jt0ShdSNiKd0XO50Bjb1T8ZfmzeEdUWvkTwbQOhUPPcqIkNQQyWwOnDxxF6W3B8/MAwL
	 hsUaBadFNPKMkWpXSrvbaayP8yJjTndcZmUJVjveqlBvmAyvU+5LMDw5lxMX6qVDOuaLu
	 UkABwymm2nlGpIQJMUAff/OTC+yn55l8IJAoGAI1T/C5OM6JF/PMroefmUfMgpHg6RRxI
	 d0tS5U1rSHYyxTzKcvZzTtHjRAv9CrPz0fJE7LGNQ3bFZDy3DS0KoEVLhgAIM3Kr/2eeU
	 4D0YuAbYrY8oJ7vx/8FlqPHMZr0xs+q8N95xFJ4u1LB3kWsXAtpJYMPCDRpVzbl+tcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tp0iqckz;
	arc=none smtp.remote-ip=91.218.175.51
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC8606A32F
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 06:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9EC8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tp0iqckz
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Lf0giC54COfoOdgBhV+lbp71w6egVz2uLYQE0MSpLfQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945392; v=1; x=1794550192;
 b=tp0iqckzpPVEgv8Q69icBcpjssLvQEpkPzCWaaLXiNP6MTlJ2y5CgE4a0nAVwR9wvqPJ23aC
 tZJ/Zq4vNB5EF/UcuLXn9Ybp3BjKhNpY7D2Kj9ly4zw3YbFXm5xhbsaTj6oLW42ELRhw564mwP+
 2DtCXGzyEY897qFCR2g9woSE=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fc26a8218d0fb5f7;
	Fri, 06 Nov 2026 06:09:50 +0000
X-Mizu-Trace-ID: fc26a8218d0fb5f7
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
Subject: Re: [PATCH 06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:09:41 +0800
Message-ID: <20261106060941.44538-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:30:57PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values where
>KSM tests VMA flags directly.
>
>The ksm_madvise() interface continues to take legacy flags for the time
>being.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
