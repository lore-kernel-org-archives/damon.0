Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE54AB1D5
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166380; cv=none; b=cfyWLLB7Zk9ASNYArMfU4F6Mjj6HCydsWeTroKMkMqsXClgiFjCA6UgEjk87e0r09jwutl6nNyiY6gcekvJDItcN26h5bbHuRGlgbClJIlM8Ca6NPL9oVmm51cCu+SP8SKOSPekMpImwWsZ5cltzmrz/nG3oXIfLoOYNdDmGpDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166380; c=relaxed/simple;
	bh=G5pLTY5y5LED+aMKXjMwPNRlGqafxWZLRXYkcSCDyEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLvKKliNbFFWylx0w5OsiWEEtPQ/00yg5Kr+13W0z/GG6o0ggYG1gKNgHJFUoR5mHGNgKlpIaEKxks3WcWOYQyaSqA9ajHjXQUHw7wZlhJ8c/SXTDFexAzhQlGzDMgSAH7SbY91tTAWtT4kZrjYjff6DKtpCBDrTJSOpsK2q2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DymJK7xH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DymJK7xH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZPkk2906895;
	Wed, 23 Sep 2026 12:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=v0X+Rs8szhHkgnuPcIWhAyZce3EkTz
	TtRBKQqHEj2SY=; b=DymJK7xH6KCGN1aWSDi8yE3JeZCCm0hQdInjvaYZRKitNb
	sl2yDuJWYD4cPHPK0u4r0N9hStfA3omtniXxpaEHynRZ9NUZdggQ7y4v9nOzT7U9
	XpO+PxL7oe/Fbh6/+YhooIKtXBG55sR4NiT2ToMHAWFRENr3oHFXFkwslZyhFWbI
	1B334HuWzXx4hpfNYekKa9xlmXk6cYQIBC2BCsfeLJ0OBkoaCBbxWf7H/z4Lv2mB
	P/Lqle8a9fS6YnXCc6Y1u7OGYFyusCvin01zNALgGbVb6TQ9tmxXkOZ3MjLGdEdC
	M/ha62xE0Fq3/RrtNVNmohrqAIQ4+aJYTAup8uSA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsb5ap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 12:25:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N95f8S005144;
	Wed, 23 Sep 2026 12:25:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8rrf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 12:25:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NCPd4t38732190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 12:25:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC5CD20065;
	Wed, 23 Sep 2026 12:25:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B95620043;
	Wed, 23 Sep 2026 12:25:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 12:25:38 +0000 (GMT)
Date: Wed, 23 Sep 2026 14:25:37 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        David Hildenbrand <david@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>, Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, ziy@nvidia.com, pfalcato@suse.de,
        ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 0/8] mm: distinguish PTE table storage from PTE values
Message-ID: <1401e907-04ff-4ee5-ad03-00d88531a091-agordeev@linux.ibm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903103002.1091859-1-usama.anjum@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab3c546 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=vUGUDSKChvK0ha46Ui4A:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: ev-_JLyQr-pwEqNhXTXIZA7T8jABJbLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX3jBRFLFxLXRH
 41gkMIIRJm9VbqiK2YtOcXDOIZwYjrCdxtSZOW/HeORsfhOxpmJhhPEWSN2wE9YBL2VRhW6O7D2
 Qr3To+xxPwlTw7GeQ2a8zIO36T51bHxKzdyp7yFXdKF3rEFGszcZBbYQEl+zv+QLSQa5BvzpNIK
 C5R4wcWrvwWHRZRXWHAwBTIUpPG8PzVJkpsQifRmwR8LgilnDa74f2xP/hyPClmLnKPerI1e3/s
 fJyE7zMlic6Rx/76z/RtAMNkCr6xtVVE5VeRNLbRnsmDb4KohBKbvJQ4ax0IiGSsSTYf9dF9DDW
 Go51ekYyr1d3O9vLChpz5abCQojIKm+DNY8HzWZzpMyAQ8VmaL5ufL6oddQ5mv/Q189e6iBxqs6
 q8d6mtePYNjZn9b5/f57l92H+6h3S1U9nREt1LclL5Eqc+yXvnOU5Bwtr8lGfdC+FyC20VRDqr5
 yvBcPkksv7DCdMzUVog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX46m1QpM8dmIH
 lg16GCvD6ONwEeOosozSD2m/9N5Zt+i3zavCwk/jFQmzNEO3Hlv1PgshihWpld67QkuM0YD1grS
 xDTdsyKVkLQulaYB1Dcv4/OHkUvJzFM=
X-Proofpoint-GUID: ev-_JLyQr-pwEqNhXTXIZA7T8jABJbLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048

On Thu, Sep 03, 2026 at 11:29:52AM +0100, Muhammad Usama Anjum wrote:

Hi Muhammad,

> I've the patches here [3] for arm64 conversion which I used to find
> usages in generic code which I missed during development. These would be
> sent separately.
> 
> [1] https://lore.kernel.org/all/6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com/
> [2] https://lore.kernel.org/all/a063f6c5-2785-4a9f-8079-25edb3e54cef@arm.com
> [3] https://gitlab.arm.com/linux-arm/linux-us/-/commits/pte0_arm

I checked [3] with s390 and also against our lazy mmu implementation and it
looks okay.

However, is there a particular reason this series is against mm-new?
Should it be against the master, it would be easier for me to try it in our CI.

> Thanks,
> Usama

Thanks!
