Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84040DB4B
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320046; cv=none; b=fHIMcOv1Fnsauy3GVTF9BvW9H4mZYdTEE2SJyYSMP4Ha6ddSj2d0u477zXpicUPkbRYSNJ1C3DfxBeo1XFCWGY8hBDgCM4JoA9d/PVGX76WAlL7elznTpS7nwPsmP9/e3YHDbdDppgqRl7NCPCq4FfRbVE3OJo6EdmRSQ0ngM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320046; c=relaxed/simple;
	bh=sePxyCJHuzEGyx2LqXN3a8pwxTYqAvr8Ds0lIwLelXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCIuxXUAubVLV6Yzq1+ijZL2zn7VhBcYrxaeK9aZBq0ggehpn3b7Z4bmR3yE/VqYY48B7DW6XVTph1nzRGXyi56kk27RSJyBxrN89alkkdZT/ymbEm0PRE+yV8Nf05oDbGmpwAvIbR+6B+dSk9RrqFQOYA/dnZwyJSaeO4FvzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FE0GRe0O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FE0GRe0O"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7mVIS3510234;
	Wed, 29 Jul 2026 10:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=20PLe0W5WCIDnL84N1zaO+HLc/2Flu
	i3NV1Ycbs9FQE=; b=FE0GRe0Ogg0GxdOaqXto7RlECSlIgi6U4FPECF0W06Wbwd
	M7AONk2CWa7g6JpJI2ObBumRdUA1swYmrWpTmd7Yhg8jwPbDZPgtdHdki7lJdXyx
	a5ku0VmqhUWIT7fE2R31EKwMjGZ2WPjK8OmL/dgfnk9UoMkRCYyUVAcgLhPRPvN0
	kLIPDOKCSIvgAGARWTb1EH2yPFCJ8AUOWyTqPNEJnE/lDGlRVk3V4VuWQqKVkVwv
	H1IG3I44nBqMpAKFAi/QqfRPlQYTmOhtD2sUL446yWQE95juDDEVE2tYcHYUFzYi
	2UV21GPh0m5G/vyMvB1cyXeyKTzcyGbuTrgbPIEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ns9wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 10:13:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9uISf001554;
	Wed, 29 Jul 2026 10:13:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pge0sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 10:13:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TADL8529688252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 10:13:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E576B20063;
	Wed, 29 Jul 2026 10:13:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75E452005A;
	Wed, 29 Jul 2026 10:13:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 10:13:19 +0000 (GMT)
Date: Wed, 29 Jul 2026 12:13:18 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
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
Subject: Re: [PATCH RFC 00/11] mm: distinguish PTE table storage from PTE
 values
Message-ID: <7813b5fe-e767-442c-a356-afc1a5c567ad-agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <2c19247e-bee6-45f4-a353-2fcc60db26e6@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c19247e-bee6-45f4-a353-2fcc60db26e6@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX5gvztvTGa1TS
 cVvs9sLHjmDvl0pv/qnDx3AnLV3WD1PhcS6rWZcrYanN4eoy1jfYhO0/byBUN7m85v7yOdOHFEd
 jkwp4KNx5XSDCb91frhZzFZIHZypXvU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX1UTcCITLhsoM
 WVmB1D9GH0QMtrIKGHgL7p0GW+jxunYYOgpbX+DXyGN5j53LZmEz/XAfzXnJVoe6iYvkeEMQ0zl
 U72YvirOw6n7XecUaLxufeDZ3k7zUoWhwsOzzDr2PnO5B+rHRlQanyNs10kmLyGk0SbO5yjhmsl
 X/wsvmN7W20tzA/W6s+/Go/LRPoLITRcA0wiEE2RX3SL5wjJQy6dbIfOKXB23C7J+7CUDxsv1hH
 2UL0d8RcWDG1m2MOfvzdP1DDLgoJ5qa4fNMDY3Dujfh/q4BEQ3LxkwjYYEZLquYPNzSt8jlE0CR
 W0NplSr/y92efigHBaNWZE689G10/Vfvu4jsCRV1WwdOJDDLrJCdFPCcT3EXgYundIBLpChodfB
 V3DgSeKuQKYmWhytTg7Qp/bafc3JxPNb2dXgROBBI3XlcwL1Fe7vq5FAcDbVZ+iHosYceQA6qsM
 opbeSLXsz6GP+frEBNA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69d244 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=17MMwBHFoGJDYN7e9MwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 83X-ft2oRkMXo03OQPgEqsBuw75g_R7Y
X-Proofpoint-ORIG-GUID: 83X-ft2oRkMXo03OQPgEqsBuw75g_R7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290080

On Tue, Jul 28, 2026 at 09:26:06PM +0200, David Hildenbrand (Arm) wrote:
> > The generic definition aliases hw_pte_t to pte_t, so this series preserves
> > the representation and behaviour of every architecture. ptep_get() keeps
> > its existing READ_ONCE() semantics and converts the stored element through
> > __pte_from_hw(). An architecture can later define a distinct hw_pte_t and
> > convert its PTE interfaces to make the distinction compiler-enforced.
> > Architecture PTE implementations and most architecture code are
> > deliberately left for those later opt-in conversions.
...
> Do you have a pointer at the arm64 part, so people can get a feeling for how an
> actual hw_pte_t implementation can look like.

May be we need the generic hw_pte_t implementation as { pte_t pte; }
right away?

Also, can you envision a case when sizeof(pte_t) != sizeof(hw_pte_t)?
If not, the compile-time check is worth adding.

> -- 
> Cheers,
> 
> David

Thanks!
