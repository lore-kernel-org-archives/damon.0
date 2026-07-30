Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839F3FF1C4
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407103; cv=none; b=GY6hWYVrCHUBiGrUJkUOCg41F+GzifbR6ZbRXE4Vsf9+pxBlSykj5qpE0cQaceJoE6w7C/5M7T/fX0XtqquVFeIPo6SCBb0IA57l+alX6g+lTLJNadXFKyUzoVMBH3HwWBACYt+BngPT9pR/BhZRyZhQX+E7pVby/FfDuGDBlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407103; c=relaxed/simple;
	bh=pKljVHRgusb/ulPWnBHsXu5Iu8Mxu1QY03lTCnZWP2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmkvFVyecjGWifJwwjP7naaFeNAfSS519Nv4t9H1nXY4ggzWv6wa8bJVuQ0+PiMrc65xAl/lWhy0wCyRMJ+uvGnocsK/Ejft4b1UuWgxHDMI24awOPwuQWrC9qnHxU5kIIjSjWIwnfQ3E/2C5O5kPSvQOs/96PWqC7WTR9iuip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbuZuTGv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbuZuTGv"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UAHfTr2636729;
	Thu, 30 Jul 2026 10:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xw9bl0UjL8IGxj4aZhOi4y5k8I/VjG
	wH4N8Nftf3ETs=; b=cbuZuTGvqINoexIK4WJN7w/SOfmPaw53VjLgWWtS0g1TV6
	AApSlNPtfukyEGV6EI1+baii13lUpd2RVrnTO88JAS1uB01nwD67S3BhwpoT2ftm
	pF1aM1FG6wpbsP/2T2h/31TWb6MAMdVqk0Y0U7xObox64yGys3hlQjDIfr8/OyTT
	ZLk2ISyswnawz/KZ/3QxEn7Cz3+cgM9B0jXe3LlYa7dkclFQ8s+v8pXMLDuK64eU
	xSEo265wzDTK23P4NZS7d3IgP6C+Az950pfBRGVg8zEGHpSLAluj7s56G0jmRmD0
	INGHxNZjyqwgHLW/B1Qyfn+8b6UhtSsWVxw1bs8A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjeb2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:24:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UACIwl016888;
	Thu, 30 Jul 2026 10:24:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhjrst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 10:24:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UAOJda30736806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 10:24:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4770120040;
	Thu, 30 Jul 2026 10:24:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 832C320043;
	Thu, 30 Jul 2026 10:24:18 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 10:24:18 +0000 (GMT)
Date: Thu, 30 Jul 2026 12:24:17 +0200
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
Subject: Re: [PATCH RFC 05/11] mm: convert PTE table entries in ptep_get()
Message-ID: <9ac3f058-2a22-4801-8633-65635053c8ea-agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-6-usama.anjum@arm.com>
 <34eed5fd-c569-49d8-bc4d-a3d4b1207fbd-agordeev@linux.ibm.com>
 <fec9e0c7-07c3-442c-819b-f9f5316cb6a2@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec9e0c7-07c3-442c-819b-f9f5316cb6a2@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfX4Ckb6VFvsR9K
 iulXf5F6J1kbO3S70H2cESI4ld0w043xIGqpEZSAio/jR2ldVb59L2x/b1Cpx4Kz3J+55BAkaM9
 AupsGP2HnWvt72AfxwuZCRHnnZzHlFA=
X-Proofpoint-GUID: lqUngdZpiUvWS2H94qSv0rrypUIzUueB
X-Proofpoint-ORIG-GUID: lqUngdZpiUvWS2H94qSv0rrypUIzUueB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3NyBTYWx0ZWRfX06YvqUElSumU
 CX2i3BnWz3n82hQOJuDP+Eanqg4avWjidLhYvcVNnamNO07ZloFlgeCgnjzpU+K/axVetiCls6t
 fKTSRdUkAcS0rVX5DnmB5M3W+uSpPU1IR/K4E27Sif4nh0pOXRleMzORssdR6V6MA7b5OjvGCGl
 tmvL0lRGkg/9y7/aNGQHm7zP9EpllmztMk0bjuCc6uOo5iaioj63uiUyglAwfqaYT/no/5x3iQn
 vH4Y1m9mc+79iOqDEv4VRNaHyLb/P8hiMxjG+nu/SRMxZsyV5wIoBoehG5Qe599Oqn8bsFRSCM3
 nyuj5Wj5auh3/+ccZhKHFFSfFIyH9mArzZF7DQ5gDzyTNL3gEudzEqBeGvpOI/h3/KDV8L04T7O
 OCFoQvBOxFLH/rPHH9zdO6BPTMqXuYhm4NtAFZGuJ1Oen3ihETQeEK2CjltziDECdSbdSoTjDB5
 7szof3AH3iJlA7l4pXg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b2656 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7CQSdrXTAAAA:8
 a=7fzHlb7OYtr7bZKlnRAA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300077

On Thu, Jul 30, 2026 at 11:11:35AM +0100, Muhammad Usama Anjum wrote:
> On 30/07/2026 11:08 am, Alexander Gordeev wrote:
> > On Mon, Jul 27, 2026 at 05:46:56PM +0100, Muhammad Usama Anjum wrote:
> >> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
> >> return a logical pte_t value. Add __pte_from_hw() as the conversion hook
> >> and apply it in the generic ptep_get() implementation.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> >> ---
> >>  include/linux/pgtable.h       | 2 +-
> >>  include/linux/pgtable_types.h | 1 +
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >> index dad80d264aac2..3003ac9cd81fe 100644
> >> --- a/include/linux/pgtable.h
> >> +++ b/include/linux/pgtable.h
> >> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
> >>  #ifndef ptep_get
> >>  static inline pte_t ptep_get(hw_pte_t *ptep)
> >>  {
> >> -	return READ_ONCE(*ptep);
> >> +	return READ_ONCE(__pte_from_hw(*ptep));
> > 
> > Should it be something like?
> > 
> > 	return __pte_from_hw(READ_ONCE(*ptep));
> I'd thought about it. My thinking is that we should get the pte_t first before
> before calling READ_ONCE(). Please correct me what makes more sense?

I have a problem with "get the pte_t first" part ;) I think what we want
is atomically read the hw_pte_t from the HW table and then convert the
result to pte_t.

> > 
> >>  }
> >>  #endif
> >>  
> >> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
> >> index ed5dba42a4f8c..61afe27307ec2 100644
> >> --- a/include/linux/pgtable_types.h
> >> +++ b/include/linux/pgtable_types.h
> >> @@ -6,6 +6,7 @@
> >>  
> >>  #ifndef __HAVE_ARCH_HW_PTE_T
> >>  #define hw_pte_t pte_t
> >> +#define __pte_from_hw(pte)	(pte)
> >>  #endif
> >>  
> >>  #endif /* _LINUX_PGTABLE_TYPES_H */
> >> -- 
> >> 2.47.3
> >>
> 
> -- 
> Thanks,
> Usama
> 
