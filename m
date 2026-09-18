Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5B3A9013
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736282; cv=none; b=oKYI1pfcSjKBOZQ0D/uY42KVliQBLB4xibuolzneWFxNyA9eX6Z19GC8Fn92MpbtlMLH9ev/kA9SNEVJ6bGyIHspcNlcoClZQS01/6H6ElTBGlPj18J+k4ImOreG7QWEyVSFRHfJdiMaNX0Tt63BpMk3I/QYY34d5Ll9U8D9rhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736282; c=relaxed/simple;
	bh=CxfmQzrEOjhuFPDY1BS8dbTxfRSnF9AUCc8h06gmwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhmV5IzzRzLAh1VYhgZFxmBdl5rQMNk98xznsHgTHwatOc8suJw/QOv1DrNWEKsB0CTo02LFYL9rCK0xzAdiI1fc9TzzNcTpighNnaQUShEN//ARtF4+FGAcoyvRFDUufhsyvsxDcTje/dyQcQrfEz6ThIJzOQCjb5f68KsyU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=byvnC9Dg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="byvnC9Dg"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA2ka3990915;
	Fri, 18 Sep 2026 12:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vvXTEBXtIpBfma8CBebbY+SSqqX1Qu
	WR6+4vIHcllvk=; b=byvnC9DgZuLKYo4mY9QFMiFQ6Zc5eAvVokdOQ/jMnu/ROL
	Ihy697HfGNSs027KQksAAkjwX7YaRrLsOO1g/6wd0s+CHm/STBQ5bGQE02PrUNuG
	/jNGEuQyMJ0GgJpPIZLUjqfcXRUhYNBUGxSiAGrMMe/ZN3ie+9Negm0sXqB2qPGg
	G78+ulSPRFoKyeDh2Y4ugEz6Mth2PVTjmT/mNSj1OZo6IEDn3Mmfrt4AuGBiF3It
	82M05ljqdaF9c5/06LrZaWpRH1x7tFsqkPtu0asE5M/h1WbsI4/lZhbLwmk3A6qp
	RqNdQRRqouleichhat5Xw20CbOufAHP17/U7CBSg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvfgrx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 12:57:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9oGpj507832;
	Fri, 18 Sep 2026 12:57:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxedq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 12:57:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ICvEb851904874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 12:57:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D53820043;
	Fri, 18 Sep 2026 12:57:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB2DB20040;
	Fri, 18 Sep 2026 12:57:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 12:57:13 +0000 (GMT)
Date: Fri, 18 Sep 2026 14:57:12 +0200
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
Subject: Re: [PATCH v2 0/8] mm: distinguish PTE table storage from PTE values
Message-ID: <d4080bad-1546-4a9a-9325-7ab91161a9b9-agordeev@linux.ibm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <dd6ecac2-9bd2-4184-a034-9e13afa614bb@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6ecac2-9bd2-4184-a034-9e13afa614bb@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE3NyBTYWx0ZWRfX0a+YmMinfqLY
 thIpqQ3k+YsaEL1Nu5Xtb4MVEpoHSHo6PXFxsq+F/Wx3xKw0f3hhtQwBUt801YS/UAG/0atek9m
 HF3E84n9wG4sj7upDsGZ+DoHJXM8gUk=
X-Proofpoint-ORIG-GUID: m4DES1QILxZeg9-Jkqr1aSPqQzDTxZM1
X-Proofpoint-GUID: m4DES1QILxZeg9-Jkqr1aSPqQzDTxZM1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE3NyBTYWx0ZWRfX/T2l95nFB1Uq
 xYhD9MK3T3CmjxCnR5kdtXxgndhWw6MxRYXoXqGlboj2UoA37O8EdLIe4YiWjjUCSxbCjYPDLdb
 zLflGPxTioAC9+xJzOGZkBco09vb3ShkcVMCROX8/GZfFwvrgzmx7n0qXL0rX5zPKB/njtDxwgb
 gMHToemhE70TFtiB9Pj1PeVjgH1oGQscKJTsEGRxHL5kVet2L1efcSErMDeLFJpVDhkGjX606/4
 v67gUAI8g2+alWIwtI8/jPJ+6ph22PnYWj6b88V7/Iglrvc/jT0GvjzhQ6L6hTrFOvO8q+nsLfd
 IM1uuwdfshQ6+5Im7f+26qdGKHnOEavHW8zEdphBYVrG/drJ0FH1jWiiDkeaELYlUGloVtsBlh+
 7nM/BRgAPEjc6uhD2wSkdjVssp3wph+7cmdpYUKnvEQX/Ft2fdQFowSRajI1e1u1DVerG791p4M
 bjrU9H6l+Tvys0K+DAw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad352d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=36OLCuKFP8Pi5wnj2vYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180177

On Fri, Sep 11, 2026 at 06:55:18PM +0200, David Hildenbrand (Arm) wrote:

Hi David, Muhammad,

Sorry for the long delay.

> Unless there is more feedback on the overall approach, the next step for this is
> to have at least one architecture support posted.
> 
> We should only merge this if at least one architecture (better two? :) arm64 and
> s390x? ) would merge the architecture bits.

I am going to give it a try, hopefully next week.

> That is, we should get an ACK from the arch maintainer son the common code bits
> and the arch bits.
> 
> -- 
> Cheers,

Thanks!

> David
