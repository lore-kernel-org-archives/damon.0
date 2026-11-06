Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951499;
	b=eFc47K15imlhB1zGkPUyUJv7WtqKBpPtHFeD21uvPPsJb1uXPIUHleE41NOVlhKLriSC
	 ZH+nXHu4Wig58Q8lG3dJttuaVFiEzq84pl34ybstzNpdas9aVT/8pKX8xLPj2VKgfPCor
	 NJ/pmnvHY68OzS9d1zBXQ1WL608nERi5vagjXyfBgWRecoMimqNGcuHEZCnSreldFT3UV
	 NJ1fQwUVCUr34sQO1MbIiB+6e+6U6CkEe/ORjbeq9ZQwDslOCrZyciiehvZKrBR6FEr5h
	 /Pz6sKw9rwFYG8+dHb95fotBGWiILrLW2niZF6u/yEre8X1VyiDH+JZdrzIpbuywI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951499;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A8L/HnUYVSEblkQSsd0Qj26nxFzNN+cxfs3MphjQg/M=;
	b=B+EE0BsTU1WTya0wzUXkzkZq1LQX9NFy02SUWHZHK79vFcEzVC4bCIrPmzo87EBiiXpM
	 jZmRRdvZwfU+p9Sb02uY2NTf5tz5UkbOxTHuHXakp693IexKoSKqQjyXW1ZPjtwoZbyUw
	 yVIl9/eexRgPVbvD9BhbT6C0RaWNt8PCGlfSVdywaQfcp+oORJkxe75GmT7kUJCY/Dk5G
	 x+3KPlsTemrgs6ofkYZ4mHbcafFPwp6f1pGUHO/Z3vPn0reA4GKfVuO0FHpi36ns5zK9j
	 sUCorbqnJ9D0lrOPw6o+roNlHTehTxOoOLN8AIxTOFjBOpO036DeKKMWfIBRsj3ShCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UPIJP6Q0;
	arc=none smtp.remote-ip=91.218.175.58
Received: from mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880A606A328
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 07:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0880A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UPIJP6Q0
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=A8L/HnUYVSEblkQSsd0Qj26nxFzNN+cxfs3MphjQg/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793951497; v=1; x=1794556297;
 b=UPIJP6Q0nfXlvvfpln4wX/UfZkaGFDuF9gkUkIPdmlKEkN/imHhQCz3ox4XK08+ctE4izmGf
 DHMetZz49duJzYzwzdygnE2PamAUcsl1T1fAJvv3Fb1FBZ7jr9ga5OWjU4lI/o1eRpS4xNVVWOu
 khNo4qEaARHzv1qqESBWv7Y8=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2a97fd523a3d8c6c;
	Fri, 06 Nov 2026 07:51:35 +0000
X-Mizu-Trace-ID: 2a97fd523a3d8c6c
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
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 15:51:30 +0800
Message-ID: <20261106075130.55333-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:31:04PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
>mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
