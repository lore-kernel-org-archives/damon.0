Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640216;
	b=sUsxcIDBEnt9DaLpF+PCWvnLVGiuS3UNF42mlOWOPXdrajfQV4e3QwAraZoN9jouviSl
	 Qy9WWpCOWbif2gNZzjUXFPgmcselWMywvb+Pqj+QVBwj7SAekCMsfV2uaaQ96ydeKeKqs
	 aoVKAMJZ+2ALF9zN/zESfR0njpySItu4uhgBUVPYapdlUDvkDgxh4TcNIhdFDCdQR8gH9
	 yxMH9Aqn9Sh78YNpe2pnCbuTeW9ki4RVyDrO1CwE5BoY3BTyEM6f3D8XxQKeArdXMCdSf
	 nsmqdv5cl+Hl4t76wsvv6IH6IV6E0pFUf57b+K2b4Tmca4KXjjKLZ9e4qSF7lYGmSNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
	b=QGTKnGV0HmaMzKdk2N7MaVyGJK1nHrOrLW11lv1eQu43nZVlnp6NEKvmM2+pW0grKOw/
	 5qvCLjt7eSu67GDDq4csn8uVmKgLJL/gjEOiyYZxZdCYeOZD9PHky1n2BN0YbAP1bdQ4O
	 kt3eJklElTZ4+OEnOHVeTHq+3hHHjtBk8LrY5/iKkcrieS80UX4hNXls2ahIf3Baji9gh
	 9xV37DjwcV3V0SFohlraqG0jXWy0P9uiITtATGMPb6VVsi1dWIut4nneErlV0ByP5WISy
	 bnZLfMhPZtSUijbLCnrSVCLcVuiXV6qNzs5SlmaU+8k2a51tAlxLHfFP1vm2eY+2l/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=lipbRVcI;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B760A2629
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 238B760A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=lipbRVcI
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91f2b826fe9so19621776d6.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640215; x=1795245015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=lipbRVcIqZ2K44yThx6PJdv5D9gbFYnS6vZbs7R1Yx3Eq8W+bcCGssiXhX8mjLd8nU
         H1pNKjg6mLo1oHOF541obETCsSPpQz+va5E9bzRvnu1LLfdHwF7qpGGKzS6ysBH5x07N
         HsSWL7t6OMB7wv8YWyrjK8n+1Ubng22j+qeEGR/2U+eInNN6UfUUNlznHVSeDORo49QJ
         UUv06qvZqCbhJb6jjG9th01Bp0nixlHVx1Qd8olsZrMg+yBn8+6OhPnx4vzdhEr1Xq6h
         z8KYbYXdaqJoBMJgmbLP1NI2CNcm3Bip0Cx3B3TkbnYZ0WmcpLXRDtdLLeEb8L/p0mbv
         kwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640215; x=1795245015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l21X+DxpKDHlSbVBLdY73zXQHc1CePcjyPM6zZHy190=;
        b=txL9XHRL9gomugpG4owRKSxlFDClR03YRR6vOSKj+XjDR1Pumx2O93KTPsdMccVUcq
         a5H0N73OFzS8f6sQFrPxWZ5QMv8sf4UZ2JlgcUaAY4Gi2klCTNMsDlPmtMODRuqFMQCN
         r+A3erVDau58Krf95+3zyKauxeI0dsQuwY46aOAwNlVAntJ0E5WVrwjeCIfrwQqvS4IO
         Pz6xN4O+Z4j98VEius2G547MPwstKSil5KPLFUo5ElMvm74c661wt4dk70ot7nc4C78A
         MyX80rXe/ykgZ0le6dGZI73eKzNhQBdfVgzbQG87466CGaFHL45RhXWKZsr0q16Asu9g
         4RBQ==
X-Forwarded-Encrypted: i=1; AL+hErHSg327IzNlJv3G4dAbWAlYXRiGHi7b+sfWk4g/vf+oJW/n/NW9GnqQvTWgkdbJbhq1RDifWw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Ym7jDl+ZPcWMS0iOt3Hqmkod2JfseyAIEQ3uuL1i761BLH7BF
	T4LN3dDcszAfHMNeAm3R0XQ4sTOvEmJHBs5yLEQ+jTQIluHW0U0d0vKDU5JRQUVlEQM=
X-Gm-Gg: AYBFou3njlGLqAxZTSPIt+7BpjkDs+OzSfRAcIYmjTqMtZKEckck3q5MGksVxHehnjy
	xeU7M7C2BGg49T3FzPXlhKKeQbQCbWVUe8IOdWZBQfr7wuf5KlB+QghHJNyI5Wqn5IjFr6UsQkF
	54qE6aOANpK7P6oxXdZEJsCdMxgjzSWZwdIuVi5f8uEF9Ei/KHc0sWYk4V9RVDdVx35hoB0KLYb
	Upe4vN+K3he7kFiyqKcv/CZN9olAmITPz34H2epeJ6AyPca+SL6CxwD5BKqBc4RFOnshxOxwLN/
	9228cN7yfNwTTVlw0rfQfkZP3cpscbdimACq/y0ePXoP5sroQuB6A6ByBANdsr8oZCQd2sdS0SL
	UX5ETitNjGLaICisT3a01VD2r5rpTUeVEklGnobzrNWNxxA3HDyS0Sv3yp7l3/Pz+wsKLS7q67L
	ZXODMwWmHasU+PNoUoWsjHcL1v+Jn04vtwNc1dy/I3Df4k4PjpDOnzFFebqK7IOkQg4edMdZo3g
	wSEXHZvb0wOVnU8l5vgz7jYFRaVCtVMmgS8m/qB5pGrGR+d0InY1Ph/68pOS5DRhSZjT2wsia8R
	CVnOI/NJosZaYBNag0X9s0Whjuvkw+sOVw0qBjZYTk13UdCXdgZLPPdQqvxKD3jY6qYu3VsFpPv
	yNAkxEFLDqYVFwYE=
X-Received: by 2002:a05:6214:8581:20b0:91e:a16b:7f59 with SMTP id 6a1803df08f44-91f241f7044mr56496996d6.32.1794640215081;
        Fri, 13 Nov 2026 23:10:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:14 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount policies on common memory
Date: Sat, 14 Nov 2026 02:09:42 -0500
Message-ID: <20261114070959.3490008-6-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use N_MEMORY_COMMON for boot mempolicy calculations and their per-node
sysfs entries (weighted interleave weights). 

Restrict the node set mpol_set_nodemask() applies to set_mempolicy()
and mbind() masks to N_MEMORY_COMMON nodes.

Later when an N_MEMORY node is omitted frmo the N_MEMORY_COMMON set,
they will be stripped from mempolicy nodemasks as they're not eligible
(similar to memoryless nodes today).

All memory is common at this point, no behavior change at this point.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b10c098e9c2a3..662ab420fe03c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -213,10 +213,10 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 	int nid;
 
 	/*
-	 * N_MEMORY can change while wi_state_lock is held. Remember the
-	 * nodes contributing to sum_bw so all passes use the same set.
+	 * N_MEMORY_COMMON can change while wi_state_lock is held. Remember
+	 * the nodes contributing to sum_bw so all passes use the same set.
 	 */
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		node_set(nid, nodes);
 		sum_bw += bw[nid];
 	}
@@ -439,9 +439,9 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return 0;
 
-	/* Check N_MEMORY */
+	/* Check N_MEMORY_COMMON */
 	nodes_and(nsc->mask1,
-		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
+		  cpuset_current_mems_allowed, node_states[N_MEMORY_COMMON]);
 
 	VM_BUG_ON(!nodes);
 
@@ -3400,11 +3400,11 @@ void __init numa_policy_init(void)
 
 	/*
 	 * Set interleaving policy for system init. Interleaving is only
-	 * enabled across suitably sized nodes (default is >= 16MB), or
-	 * fall back to the largest node if they're all smaller.
+	 * enabled across suitably sized common memory nodes (default is
+	 * >= 16MB), or fall back to the largest node if they're all smaller.
 	 */
 	nodes_clear(interleave_nodes);
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		unsigned long total_pages = node_present_pages(nid);
 
 		/* Preserve the largest node */
@@ -3476,7 +3476,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		*nodelist++ = '\0';
 		if (nodelist_parse(nodelist, nodes))
 			goto out;
-		if (!nodes_subset(nodes, node_states[N_MEMORY]))
+		if (!nodes_subset(nodes, node_states[N_MEMORY_COMMON]))
 			goto out;
 	} else
 		nodes_clear(nodes);
@@ -3508,7 +3508,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 * Default to online nodes with memory if no nodelist
 		 */
 		if (!nodelist)
-			nodes = node_states[N_MEMORY];
+			nodes = node_states[N_MEMORY_COMMON];
 		break;
 	case MPOL_LOCAL:
 		/*
@@ -3903,6 +3903,9 @@ static int wi_node_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case NODE_ADDED_FIRST_MEMORY:
+		/* Weighted interleave spans only common memory. */
+		if (!node_state(nid, N_MEMORY_COMMON))
+			break;
 		err = sysfs_wi_node_add(nid);
 		if (err)
 			pr_err("failed to add sysfs for node%d during hotplug: %d\n",
@@ -3934,10 +3937,7 @@ static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
 	if (err)
 		goto err_put_kobj;
 
-	for_each_online_node(nid) {
-		if (!node_state(nid, N_MEMORY))
-			continue;
-
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		err = sysfs_wi_node_add(nid);
 		if (err) {
 			pr_err("failed to add sysfs for node%d during init: %d\n",
-- 
2.53.1-Meta

