Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945013;
	b=wV4F82J57h+5f9jaOg5WSWvDU4gVAG8HQGGPTPMDJyzyvicRS1MVx4jwwaw6gXE2ul/h
	 0w3J+3y1pawL24afGERFjlc+4Ld8fs0LynPHasvgZKup3BjvviEcuCHJCHUBZEFxp0dFY
	 HA5IGzZTHgpmAWZGKcla9KzFfI73rRYfXzB9yqVqCJRIc0rsfLzzoDM/JbxEOKCeYrjUH
	 lXpyqbpKwq6oRZRTZlfI7MEnI/LRj5Eso3H+5vo/rURuq4fO23jP6sDpCVoXk55kmjHcg
	 vsflGrUi2P9/sHDLjC6g5YVbM7golwky/NY2i34SN+p8Pv+HA3ZvjO/dT+93PLcQwkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945013;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1dv3z5zT9lsczFcdl5n0QdTgMSuVwfBVBoxw3rRXK20=;
	b=fZ2SQrW2werYbagYhs6WLKPE4TpcxgNskNgBL+7JjND6UNSdCzyLuFhbkYiFog3fCi6H
	 mZWZutoOd3XOfmwlOdJIwQ4RqRuz0V3zKcygOc+SRAujEN2tBy+Thx4Lze5b2+Ibm3yD1
	 1QgXXii7FhSjyDkOEs1bYUEVIZ5OCa4l3CQWjZulftY7B4ishr8b2GCX2bIjPL5zOV+ii
	 AT498CtyFP3Fxblfu+FsAAbL4a81rxIo1J7knbeTxEexQwj0h3Br4slxlpYhnusFsVugV
	 oi+ZlmGTv64t4gJokaASn1DveVKJUbDJEgQTn67Lnd2WWiK/JdgXaaiVLFDOkO9kjkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Equb2DTs;
	arc=none smtp.remote-ip=95.215.58.205
Received: from mta1.migadu.com (out-205.mta1.migadu.com [95.215.58.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6A606A328
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 06:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C6A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Equb2DTs
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=1dv3z5zT9lsczFcdl5n0QdTgMSuVwfBVBoxw3rRXK20=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945011; v=1; x=1794549811;
 b=Equb2DTsW5lM1cyS5BmOLbSUEiZeHwWdMntbvWutT+GB+cbnZu+270jtQhqx3NeTOeiNwcMQ
 NxstduOKiNHidkSSEZQgHoWsfbr6DhlJ2k1xU7KZjJsn1AkvzfiG2FtKtuxNmumrv63EMFzyvyq
 D0OTMPvtDWSrDzubRGc2rPYw=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id d15d1ba08f67e7a1;
	Fri, 06 Nov 2026 06:03:29 +0000
X-Mizu-Trace-ID: d15d1ba08f67e7a1
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
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 14:03:20 +0800
Message-ID: <20261106060320.43724-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
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


On Thu, Nov 05, 2026 at 09:30:56PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values where
>VMA flags are tested directly in the THP and khugepaged logic.
>
>The thp_vma_allowable_orders() family of functions, hugepage_madvise() and
>khugepaged_enter_vma() continue to take legacy flags for the time being.
>
>Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
