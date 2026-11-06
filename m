Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944721;
	b=IlR/zHeQ8mGpaWCoKbe6HJLiEeyDxRzCtcrrCKh535bq2YbD1ZZUXyqEP5f/Oczj5vt7
	 DJtVTOK/fy7XPU/ZkBJzEO4UclHYOy/DFXuZ6Z/RQ7gQwe9qDz7G9kRJ5Cd3lrWpqDiOc
	 j+LUL7g1gYtmQ7YP+a5j4r4AGGI5EoL4VvI3GW9KeRPN0lIh3PvZVQqXC2VpRS42hODAG
	 NpLjji80zHJXUG3CpKpAQEy2tBKUFyaH9JWC20JmhkMoqLqEZ3vXsNaVkM2I94Rkmr7VF
	 eWkzif07uUI+rvsKP9EX7pFOeaA+mhQp3AIcfiJFFyjghi/Jq8M21BindFjQPiMCs4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944721;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PkBehpMQ1APfXjT2IE3+mlc+y4KHDiIRfa6RZSDO6oE=;
	b=4Mn34BHOvZD7nIidVrSKU1d8RJSBUyl1lrITPIgMhAJB0NKzuYpj5fy8KI703HDCHKua
	 hVg0Bx6YVm+8rWYpUSpQeabc2mqIxcJCqVIDlfXhcMsCXTYJ22R4/YyNEredGAIypiKIP
	 0aC6wLLLpZoNTDfZfZIojndBpIEMoF90gyYyeUQkw049mxvfRMGHkyQZ1mXBbZxPYG5Du
	 vZI3MZUGZZ7cTKvKIVnzgSEFjF33o+F5GzNt1DBjB0Jo+lPustSBLairYAeMq2DlukmE/
	 xB7jR60Cx+PdNmQi687UxGWPz2CA/hAxEAINiZH+t+V3vQZ+DhlUC+GcRj0boNKnxag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XdOrnOff;
	arc=none smtp.remote-ip=91.218.175.132
Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A930606A32E
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 05:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A930606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XdOrnOff
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=PkBehpMQ1APfXjT2IE3+mlc+y4KHDiIRfa6RZSDO6oE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793944717; v=1; x=1794549517;
 b=XdOrnOffQTx1UPchmwcD3G9CjSPrVCHD4iwwf1eez29n+8UuEmQWBnNuo+tv+WX0jYnIuuKn
 ZEDuk3T+aac75YrXwLgooXesiE0yhoWtAL4UfUotSKwnYE+DimImSE5t2leD493mh2Kd5la+QK2
 G0d1yur0sUNpDmcaS0qriDm0=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d93371a15e2af6bb;
	Fri, 06 Nov 2026 05:58:35 +0000
X-Mizu-Trace-ID: d93371a15e2af6bb
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
Subject: Re: [PATCH 04/13] mm/migrate: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 13:58:30 +0800
Message-ID: <20261106055830.43260-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:30:55PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>migration logic.
>
>We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
>there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
>take legacy flags for the time being.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
