Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D4492502
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576138; cv=none; b=XqlhAxEB06YZNvu1np5eZtTGJxEb45AH4TliGXxaY/SAV2wUq7K04OGz9Iy+LFECKoP6BzUA5y8P7ZSFPtBPqPtsow8bMXE8AnmChj7CH/w1IEDtSP3bTThXZcw0aF6nCzBmYoKCSFjUzB+O/jAQm9aHMJMY7cEVWAxWhras5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576138; c=relaxed/simple;
	bh=g/xiGWfO3mFmUtpjiaOltFkKmHg7U6hIcXuOmsbgzC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf2Lu4pmLERM0YKFHpcrngXqPTS7B2SyRgW8pTVMxzDhQuqnejq0fTub2oeyWugASq6pHDtoJtsRaCOpWXsj0Sys3lx234zozbAqlVqbu7yZWxWLIMc9hwjgVNRAQotGrfP6SSGlLDBcti021vRjOcdh5HVqqSDVELB8VLomksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IZaGPdXE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IZaGPdXE"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5d50b0dbso540134085a.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576133; x=1785180933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bbISnSBqmxoccJ9u0omFuHBSz5EtUsg09tULZikjEs=;
        b=IZaGPdXEgJygyzxoVV3eVz3YBY3m11N2YzApZq1koPX11IlRMJzzMa2Hp60UmjSlva
         4Cq2GoiD4Wm4VdU7D0jhnq+2RBuqebk5gzbof5r5tilQtVDPyj+5J8qOnm7gX3WAD6nD
         5thBwJ2KM0L6cohVgKv0Jp9oAxZHJUHxHfzrZScwU0lR6Hcpdh43IPuxUgQbEBqt45O4
         7Dgb+DaMH68IdrHhdhpWtuUHy+cff+MDcO648VpoQWxBmvk0fEUprOoJ2oKGjYMXb9aQ
         B2sE/mMGNr98kK2urmQLFoem6ui+dbj7y4/KVvwWiFgOtoClR1YCPiU5Bu3nZxX0N8HK
         b/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576133; x=1785180933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bbISnSBqmxoccJ9u0omFuHBSz5EtUsg09tULZikjEs=;
        b=YsYKaM8j6jXxxTto90tnPbsMYE/x/N2hcqEIXknW8oLYibpGfmsSPCKtrmB1Td6e3c
         9bUGMoUKItF5W6wFRUxIjljvHRTwGlLtc1ABMNCSuiZCVsgg0YXZYVL21LOLqeSbaxnz
         e/RMcINX13IvepOVbh+1FY2TQqLjd5fu1oGgHJ2dhTBd60xybHJ4l9KEcVBnz3WcyaEX
         bCFXFlCwnHMcDSxAjItfeRcUSZ0B9d0+Jr8JRnuhvL1uWU2cdcA4Vi+AgIA5v/TJHLJ5
         BgCloLXhtg8eUZMfPLMwwKdJGJWxKfZZ7rLxBToc9k5fDEE+OhVuZWi/9NE3Wq062Sgd
         szUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBa/HZZ6ffzE6iiF5Um04/U4B52mr7L5WUfpdO8TM2IuWATY12We6XNE0qO8Ik/2cLaCUMTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQAE0+93vgxDAqu296L8DK6T/yEUxlJdxkK2PyXFMw38/3F+pt
	uWpellG3MsfYqDYTfnuuD+Xn9VtYpq8wkWKr9cn9Mh650JL0aSZxWxL5IGYYCOZV3OU=
X-Gm-Gg: AfdE7cna2Lny0XXQuuyAkhtEq1UEgcRREo2CpbMTg2Fr9tQ+donk5SZhA1P6i+nh9Ul
	ISETk0SYW/nc1D5AredW5n8XQ4QZzcfl+meMFnsbZkeifV6tSiwA6em0fyeoEqCyqZfvPwShf09
	YvvrctwCYK6v0M6deph3sX3obX08wPVE1dnpBjF6LO55PNQm5dH4uCv7ZgVq0DEdD7lrqUwPfHQ
	KvkXpxVAJVv+OLEBAKTaMlB3VnFFEUgVD3FBfYiFgw11fE+LPJ8e7v7QN+lMNenetS0pPSmlM5Q
	mUQN3vE+Pk2CrBvv0TpTP61JVkqPmD79viBPJIoP5xK2kUzNhf2tVvTdDtO+ecx2H7j9Z06wjtw
	j7KoKPKq4sGcx9h8/q+nbUo4C9KpeF5VNYz7P7X4H8Lumm3GumUHp16S+f8W7i2rQ8DkqFLNaxT
	pYl9yD/F7NfC45VeG1jus5LI8RythQrwU+6NMASAIFyisfREXDOYJ8VdTGAd8IfPw=
X-Received: by 2002:a05:620a:1a21:b0:930:9afd:e98b with SMTP id af79cd13be357-930b434f8d4mr1589642385a.88.1784576133081;
        Mon, 20 Jul 2026 12:35:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:32 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 21/36] proc/kcore: include private-node RAM in the kcore RAM map
Date: Mon, 20 Jul 2026 15:34:15 -0400
Message-ID: <20260720193431.3841992-22-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kcore_ram_list bounds its scan at the highest pfn in N_MEMORY.

As a result, private nodes placed above the last N_MEMORY node, which is
the common case for device/CXL memory - is truncated out of /proc/kcore.

Include N_MEMORY_PRIVATE nodes in the scan boundary.  /proc/kcore is
root-only (CAP_SYS_RAWIO), so this exposes nothing new - it just lets
a debugger read private-node memory like any other RAM.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 fs/proc/kcore.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 390547b992acd..f67194dc2a9b8 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -251,11 +251,14 @@ static int kcore_ram_list(struct list_head *list)
 {
 	int nid, ret;
 	unsigned long end_pfn;
+	nodemask_t mem;
 
 	/* Not initialized....update now */
 	/* find out "max pfn" */
 	end_pfn = 0;
-	for_each_node_state(nid, N_MEMORY) {
+	/* Include private node memory in the scan */
+	nodes_or(mem, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
+	for_each_node_mask(nid, mem) {
 		unsigned long node_end;
 		node_end = node_end_pfn(nid);
 		if (end_pfn < node_end)
-- 
2.53.0-Meta

