Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584A3E8C71
	for <damon@lists.linux.dev>; Wed,  6 May 2026 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078632; cv=none; b=RUIrw8uaThtqgqMKgxJZNZUDtGNYQXqY9iADEYhmg6jAIve8dnPEW3jRWb/IiN+wwz+S5GzAOgp7+GQYssLmHbVSI5y2jQftiMmssexH4X3ZtbYN0gctNAyxAa3xujA/V1USBAkcVMnkHMvtrShZ2Zm2d+WbWZWJUmX9R8bN3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078632; c=relaxed/simple;
	bh=8rYhAkFOKY6K/j1/wpxkQvi3y7Z+5CCbQC0nxatTUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVH6q0/3xED/ld39HZ3+asuqJS+FjV5cJ9ilTf3/MWPAx2Caq3GunSX2NuG0gSPN9d5oo8tj03DekeEMXiwJxC00hqSxHbVjmMOP6U30GvgkjVVEOZicDHGPxjwTQc7LPVeolqk9XSiQFdhhqhcpoCptzsMwKBBBH8qp3lfmJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rCqqm6mW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rCqqm6mW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4526a8170ceso148810f8f.2
        for <damon@lists.linux.dev>; Wed, 06 May 2026 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778078629; x=1778683429; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=rCqqm6mWrvQy+8LSaPu0AdQr8ueYakUMZMahj9yp2lsk8fCQgLE0Ua917znmZWXP8/
         Fu1uyX7ilCISVIshilc1pWYT6rpS5SL6X2zh+b3oExXOdDklI49kG5liuVig/bPmYp6a
         +Yht5cg0FgDFa0Vizhr3W/2nfZHnY9zUtjdlCM7wp5vl/4l2mxHsAO7KEfCnVyfQPrXK
         AxakLnzbDBiQCv/6P+DTBzk5XohWf/kCVxuqomHZUhMEeTkSfF0F6nklxh9tYwfjiQqy
         DoEqDadVZAr9b2XZwgH8ZkHPJo45hCc66Jm/D+FWn6YmDG+9J19pdmwQ1zvIqhXzzUHB
         3aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078629; x=1778683429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=ZIg95zn3TP36XnwWhcUIvhBIQVwY24wY/PUIoPpsN/tITpYgzc6zwmsPn+64mQp4/3
         aS3xXG1THePvGvtiiACMDZ6PyylaMg1rPgXhz+mzZIA2CSWQhOvV1injWDci/9kLswD7
         aBqSnoAtIAna06akp52GXb8RWSh8OGjpItQieMXPJDyE+DFHhKbxxx1hQdyhVjHVquGK
         XHjPmIcMetsQzKm6T3fkj+Zk4Jef7dQPz3wSuvkzWCD80Yy5EdOnNN0xouVBxuhbuje+
         qw6PJ2PxSMJpJTcsqXpg8rQfaSFxwbYBBTV8BbyHe0u/w8HzmehahmqIiMe6/dXUktLg
         OsjA==
X-Forwarded-Encrypted: i=1; AFNElJ8flDzsOprduuPnkFRESMtHCNstHVLx/YrzyxBOvEJa7cXtUiQvKxZJs8Cv5SrSEipz6HwsRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl1cTOhiKv3LRwXazg73bu2LPEk8CSciQcV+KkoYvoGlBzMDMJ
	uPlzhH/tenp73N18EBdO9gn/vdIW68Q/gjj9T3lkVTNE6oT0qOsCf7Zc1aR1DV4uEIg=
X-Gm-Gg: AeBDievvHOAZC08ic+nEx0gB+LPf/+EGaKSBCy6d783rTfMtm6slcpPjtci468QkX5J
	1xhnyYA+cKSd+wnvdba2mKVUmqostU9s2K4qQOAfYnhet2a9LfcaCU66jjG5nGYSCGe2x6DOrG7
	Fup1d5JbCpfuySioE74uJIYR4D0Ity2xhtklTI5SQsRY5UxM0h3CLMzl0aXvoMb+/qTxqvNCZHf
	9ItCsiBQKQ2TP0VXFNtSWyQS3Be1Vlr4GY8CV+nJ7dT0qqcFhH+K17abbMaXB87d2GIqhhpN8WY
	bioR4/HdoG9o5rXV3nkO5MYIFDB20v1vPMnu/2uvCG3FxVJhUN0NkVPchAgYSO76rarkXfigJ6T
	1DZL7RdsjPBnXYUqlA4Sv7hRnyYZiXd2EQBYOfQWZRfsXRYeTlF7HRiVwv6zksxptWe5E4yqEh7
	xdYodKL8mvMwApCR9hRJW5VAMj7K7Rqqf0R+R90J/2KtSevw==
X-Received: by 2002:a05:6000:3106:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-4515b524457mr6633850f8f.11.1778078628705;
        Wed, 06 May 2026 07:43:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.185.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm13732451f8f.31.2026.05.06.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:43:47 -0700 (PDT)
Date: Wed, 6 May 2026 15:43:35 +0100
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aftTlyHYNr0B9yL3@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>

On Wed, Feb 25, 2026 at 12:40:09PM +0000, Alejandro Lucero Palau wrote:
> 
> I can see the nid param is just a "preferred nid" with alloc pages. Using
> __GFP_PRIVATE will restrict the allocation to private nodes but I think the
> idea here is:
> 
> 
> 1) I own this node
> 
> 2) Do not give me memory from another private node but from mine.
> 
> 

I mildly mis-read this question, apologies.

Multiple private nodes in the nodemask are ignored, because the nodemask
is a filter function for the fallback lists - and private nodes never
show up in the fallback lists (except for their own).

So for example

Nodes:  Normal(A,B), Private(C,D)

Fallback lists:
   A:   [A,B]
   B:   [B,A]
   C:   [C,A,B]
   D:   [D,B,A]

            combination                       |  possible result
----------------------------------------------------------------
__GFP_PRIVATE + pref_node(C) + nodemask(NULL) = (C or A or B)
__GFP_PRIVATE + pref_node(C) + nodemask(C,D)  = C
GFP_PRIVATE + pref_node(C) + nodemask(ALL)    = C

Basically private nodes are completely ignored in the nodemask, so you
cannot do fallback allocations to other private nodes.

There is no good abstraction (that I have found) to communicate
multi-private-node allocations simply because this would imply needing
private nodes to be in the fallback lists for other nodes.

Maybe there is a possibility of modifying fallback lists explicitly, but
I think that is out of scope for the first implementation.

~Gregory
