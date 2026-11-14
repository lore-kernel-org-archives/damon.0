Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640214;
	b=tHesHmTO1VdOhSDFamjcwXLRhcVMWZH/WrYm2JW2w1cUsKMWOFKH9DHit4VRBuXi5maG
	 DtM3R89GfVnYnkRYI5TqQ4fIal9rHLKrX63dEOAve69j3DK/1fdS6OJYxlxy1r0sag31K
	 1+XHza5muuILid5npXyKkTpS4VFDivCy+Q0m+Ql4QOpoHepkh7y142U5qJXfks+tqBfSq
	 8qnA8xa1BtYfqn91gUUpQ++3iDB/dmxNksBVQBDYF2Sji1tDSrfh92HGtgrgASGRVAuEe
	 wlPKV3SHpqxVFUeMTJJ0G0mVaAaTFabmTK+0ge4ACa4V/N92Y7yZRYUvQDao14LiBVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
	b=b/t/SuvgluhDkXOvnFxcxziaJl7sAA9wVL10q/aKJwBDZ3Fz5JhHC8FqBS7m56gJLq68
	 TvkLwGSENPKXVPEtrwgIc8JWyEwBsFvu2sRQiDsDsk570XSM2SBuXW3TrTUV8kctKhXxo
	 dX7569LAkGkvXBLoa3tig67mJIH14ApaJ28bhmRyYpzxt7VbSDUlBGMYulM+mo3T679F8
	 qF/cbewrjD68+JNv00bpp2ZPT+2HXT0OThkU1H/2BOej8EIwB/7DYUjMWFhptQ6YjPlqx
	 mQa+MBjO2+NIe4mW3CZKZhb4EW6PddkYcMfJAh6zNQ87cIsgkiDqe3/12ZXRvYvuHQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=mxC+7WOi;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6C606A8B8
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA6C606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=mxC+7WOi
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-94961bfe1a0so38525885a.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640213; x=1795245013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=mxC+7WOiFDhiDXXmLHu5ocKxtEpD82U3gSrosQQq+Udm2zjq18AYeQr/864Jsp/Ww/
         BtQB9WXLFN+ih4jCSXPH1UmcCldLGEk5W7X6aEZW5aGvqpuaBKNX/LjelwNa5C99GwyC
         7eaDQm67NdLYUGq0GqT5fCyCn5tTq4+Zo896esRqAZ/Y0goGw6FMVJ6ZJDN2eSWea8EY
         TgF0Lfhxea37KL2LTPYke5+xT1A5beNT2/8uLZ6XIARTA0aTJ6sTBDuWCNlJAfD3CK4e
         PhJlurHWs0+wDsBo0oV7BIaw8tf/hWngYxgk1Tc8oXH8uWUQoK0CYuJVUWmnGyoZj9dm
         rIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640213; x=1795245013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dol9r1sYlhR7CIgJNfl3WOVG5mT9B/6UaBUUhYtXcU8=;
        b=m8T2I9efcEPt0chn0qAN03beQlMkbxCVdw8jdbreOCJPEQi9fF6DwRzfPgWbJnWGUo
         zlLzokJmBmLHHSoOL7eopfJCEXPOCE2OK/Nqyw3LjXs3+ZBjZ1AdinNEeNJU/3Atkb2f
         cjsEezh1FWxCHzqTmnYXxCQoMWBeRcjemmEDZUAIA46WsZa4CYgR9dn+YUOOatRm0reZ
         vPJszL0bf9bGPZWotS8JE1vvbuHLPD2jaY0w4d/0bKbGyP6zAV9Ihnx6c1GoFcDIXZQb
         f1yn36CBk303gDEQTHeil9LoJT6ialHSPJK26Gy6Cp17nwz8iZM3VoMOYfwRvttOCJHY
         4fuA==
X-Forwarded-Encrypted: i=1; AL+hErFdegmdeRfMOrvIs60+d962fAm2JE6u8WAVD93DKbpot/DvlFJsYrFSrbaiDjZlMfnbN4t0hA==@lists.linux.dev
X-Gm-Message-State: APuU4Z95zOyZFycI0YI+GypZXUXQP71pIltmdEIkTztywJvNxUY2TsXA
	i0D/Wa2NKJ0wjVWp+/0B+B9pY55UcxBLFK002IEePIoMAJmjp2OmeArHREjHlYFbHIU=
X-Gm-Gg: AYBFou1zH3teDl6AlQvpyhlowazJuzIOoE/Tu18P4d+llYioi7lTdhPM0TayssKevof
	u1fpqwO77E/qR4R5hFHBodAw55Mz/CUx21iIn55c0SE9lKXLxd0dINePddUbLLDjnMNKPLD/+vI
	ZomW3uwxHIItpoZ+ogjd+5PouWBWBLc2uxtv8mUHXSXd7x4xDYNj9sflihktyibaKboDN5qC2ln
	YmSzddgiNDywQWrR77JeRYDQbziPId7xWlcyZ2HzRHkFPxLWVBiyePTl0VaVCEkB61MzL4dThCe
	5vmX5LlWU8HHl3G+a3IJ7sX2pdB7SbjzBadqOqUJrwiSuadtlwjHO13ct/XrQ9sFVm9fziOIoUm
	GgfegwMg3+R+BUFpAeND15+O+7I4pw4qI/kWOXogjj4yiZpWbCJ1xEYv4m5lGRN3VA5JtIrwbMM
	7vSUKFbaO7xAAO+JEM6mWsv7f3VVptxM9Tk9yQW3etgsLQjSuoXev0GsRDto9ZrAp8z2XrKb1qf
	Drx5j1yTUTCnpk01d7uWXYxrPlIMHbveqGEu6fsz9jzFYooF//N7qxZStcqJnZX/Wg81AUlZy0w
	tzXZKqH9AMnQbC/buvzMSKc+QALj13whAuoIPMc1Te5Gs0hQCrj/VOGi3Ikbo7uVFbLhlxbQuUh
	jlDv5iNQa3/bjh3Q=
X-Received: by 2002:a05:620a:7087:b0:949:402b:f18e with SMTP id af79cd13be357-9494bc7e777mr835710585a.66.1794640213010;
        Fri, 13 Nov 2026 23:10:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:12 -0800 (PST)
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
Subject: [PATCH 04/22] mm/page_alloc: build zonelists from common memory
Date: Sat, 14 Nov 2026 02:09:41 -0500
Message-ID: <20261114070959.3490008-5-gourry@gourry.net>
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

Zonelists decide which nodes an allocation can reach.

The fallback lists hold every node in N_MEMORY, and a node's
__GFP_THISNODE list holds its own zones whatever the node's state.

Ordinary allocations should reach only common (general purpose) memory.

Build the fallback zonelists from N_MEMORY_COMMON, and __GFP_THISNODE
zonelists only for a common node.

The build_local_zonelist() refactor lets use reuse the code to build
a local-only zonelist for nodes outside the N_MEMORY_COMMON set later.

Every node with memory is common, and a memoryless node has no zones to
list, so the zonelists are unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6ffa972811462..580feeb608b7a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5906,17 +5906,14 @@ int find_next_best_node_in(int node, nodemask_t *used_node_mask,
 }
 
 
-/*
- * Build __GFP_THISNODE zonelists
- */
-static void build_thisnode_zonelists(pg_data_t *pgdat)
+/* Build a local-only zonelist when this node is eligible. */
+static void build_local_zonelist(pg_data_t *pgdat, int zlidx, bool eligible)
 {
-	struct zoneref *zonerefs;
-	int nr_zones;
+	struct zoneref *zonerefs =
+		pgdat->node_zonelists[zlidx]._zonerefs;
 
-	zonerefs = pgdat->node_zonelists[ZONELIST_NOFALLBACK]._zonerefs;
-	nr_zones = build_zonerefs_node(pgdat, zonerefs);
-	zonerefs += nr_zones;
+	if (eligible)
+		zonerefs += build_zonerefs_node(pgdat, zonerefs);
 	zonerefs->zone = NULL;
 	zonerefs->zone_idx = 0;
 }
@@ -5960,8 +5957,12 @@ static void build_node_zonelist(pg_data_t *pgdat, const nodemask_t *candidates,
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	build_node_zonelist(pgdat, &node_states[N_MEMORY], ZONELIST_FALLBACK);
-	build_thisnode_zonelists(pgdat);
+	int nid = pgdat->node_id;
+
+	build_node_zonelist(pgdat, &node_states[N_MEMORY_COMMON],
+			    ZONELIST_FALLBACK);
+	build_local_zonelist(pgdat, ZONELIST_NOFALLBACK,
+			     node_state(nid, N_MEMORY_COMMON));
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.53.1-Meta

