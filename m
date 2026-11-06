Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951164;
	b=2Z7POsNJ+pgOMqWf6sEBCiR73GALldCKtCSPGQ2rqQJYF0Ud3DAYEZtvslO9PavEf+0K
	 GhDg256b82I09GI5zrW0nVL/4GQquX/Inaw7MVBYxPTP7tGPT8zG3NL1hqWEInGAL6LCU
	 JK55h5O7gtNLo3o8OasJ2DyyzyIF5VpWczjfrt7KRQyP25iZstXJmbQemEZtcY7d8lmmQ
	 KWLYD82K7UjfC9rBT6Y/6vAlGLAWhkcB1K08Dsf9853jjChA3a1XfuZZjjxhYL/FIUw8B
	 PlydWSnhOTjOKimak9Qd2ap4QeK7XKrMRy1TY4s71Rn0oqFHpYcog4Ui3eiID8EcZDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951164;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8RPjRkRw6TGzo85+j1RMaJO9Gz+t0O/3LiAQ/KX/BlA=;
	b=fuRBV1LiCAr8e9oL5Z1iIF6HFjZz8m+OmsLFRaU3S2us/tmrBeIUPZThv1IienfzMSa9
	 81MO5Ycs6PeZdqheOHr33Wk8a1RCoWWKA1iR8bx4r9r3wpd6KEfanrONn7uyDu1RMbS/e
	 2ZNiUY2CrSrHeS2fT8ZruMexz+yBaLaEgLGITc8j22D8qfU+rnoJNt5vgXVZMHGHvF30P
	 hsSAQghCx+SPJdLEHcWtlfiIkUF8huoSbdnH+SeiS/+xqYA4XdGXyH5Eb7QUzVw7N1a2l
	 MGx+l8F6bDXkNUUWMDO/cJsg0sX50a4KS1CJD4VIqL7y8nvSu0MNd5bTppsYgzZi7dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nj9sDAKN;
	arc=none smtp.remote-ip=95.215.58.239
Received: from mta1.migadu.com (out-239.mta1.migadu.com [95.215.58.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B72606A32C
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 07:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B72606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nj9sDAKN
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=8RPjRkRw6TGzo85+j1RMaJO9Gz+t0O/3LiAQ/KX/BlA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793951161; v=1; x=1794555961;
 b=nj9sDAKNfkvbBGNxUae68sem25H3PJydnfLYRCEquTfzOGknOJJaghCjguFnHEM1Tv2sOAqv
 1Dlhalz3OIiYsrxXcBlzYQ7L5wC9z9d/t1tVu2xjsUHyj9DmQPymjq+m+Nk6PEfXpKvCGwRWJhK
 UyWYLWpQac9Ccw6BbX++PldM=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id a2e578c5cb1dba6c;
	Fri, 06 Nov 2026 07:45:25 +0000
X-Mizu-Trace-ID: a2e578c5cb1dba6c
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
Subject: Re: [PATCH 12/13] perf: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 15:45:19 +0800
Message-ID: <20261106074519.54904-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-12-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:31:03PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>perf mmap and mmap event logic.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
