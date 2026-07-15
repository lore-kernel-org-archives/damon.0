Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AC13777E
	for <damon@lists.linux.dev>; Wed, 15 Jul 2026 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097413; cv=none; b=e8rKE3AN56y5rDAjEWgygJ8xVtLezjqHAa+UqISx0lJIguf4JTETPDa0nfoFpQviHBrGY334DLW+sdEHHyU7t2gxc6I3FuNxNBB0NF2hOXdLaCsSVoqB3xerWBaulVNyPdszuycteZL/dLqDcy32ah3SBuFfLbq/u6fN9pyPcm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097413; c=relaxed/simple;
	bh=lHWFAN5V1rZuE9SKbUpwlQ5trv2XwqzOdYVJ4R9hymk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rfq6klpHXbVbtZ8Xf8T7++yplKjZxEnTB8pysWUkpIOzpGv3aEliPWzIiROnyoApcgH8b99rhpIG4bBL/EQkA3Kkan5zNCkVolx1pW5yD7/mlo2YWwJLemX+DZCUpwkqwHBR+59ZI0oQzr73Gm6lucGpCKQdkjm1Yk/TuN+x954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 88e2db24801711f1aa26b74ffac11d73-20260715
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1ebbbca8-8188-4332-b0d2-b0c61b1a6200,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:1ebbbca8-8188-4332-b0d2-b0c61b1a6200,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:23cfdd90f13b350b13018f30ea2c12be,BulkI
	D:2607151436424G3QDUZU,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 88e2db24801711f1aa26b74ffac11d73-20260715
X-User: husong@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 670843981; Wed, 15 Jul 2026 14:36:39 +0800
From: Song Hu <husong@kylinos.cn>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	Song Hu <husong@kylinos.cn>
Subject: Question on damon_sysfs_memcg_path_to_id() path resolution
Date: Wed, 15 Jul 2026 14:35:46 +0800
Message-ID: <20260715063546.1427154-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

I've been reading the memcg path->id resolution used by DAMOS filters
and quota goals, and I'd like to ask about a design choice before
suggesting any change.

damon_sysfs_memcg_path_to_id() (mm/damon/sysfs-common.c) resolves the
user-written cgroup path by iterating all memcgs with
mem_cgroup_iter() and comparing each one's cgroup_path() to the
target.  It could instead call cgroup_get_from_path() directly, but
the two don't resolve the path the same way:

  - current code: cgroup_path(memcg->css.cgroup) is just kernfs_path(),
    i.e. the absolute path in the cgroup hierarchy, independent of the
    caller's cgroup namespace;

  - cgroup_get_from_path(): resolves the path against
    current_cgns_cgroup_dfl(), i.e. relative to the caller's cgroup
    namespace.

So in a cgroup-namespaced (container) setup the two disagree: today
the lookup is absolute; switching to cgroup_get_from_path() would make
it namespace-relative.  On the host / init namespace they agree.

I ask because the iteration has already needed one stable fix
(d4e7b5c4cc35, a missing mem_cgroup_iter_break() that leaked a cgroup
reference), and cgroup_get_from_path() is a matched get/put pair that
would avoid that whole class of mistake -- but only if the namespace
behavior change is acceptable.

Is the absolute-path behavior intentional?  If namespace-relative
resolution is fine, I'm happy to send a patch (keeping the
mem_cgroup_online() skip).  If not, I'll leave it as is.

Thanks,
Song
