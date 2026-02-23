Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35D43090C1
	for <damon@lists.linux.dev>; Mon, 23 Feb 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862924; cv=none; b=mbx1stnP4NFHf1UjvVs3x59033Q4xFsmMZXv+Rqw2jGlxoffh4+mgTk15pGpTDdoOh0npt9b5272DWb/0TxFr0RFYeMl8szn2r1kOmniVECMRt0KnC6n6FV0Hx/qN3DckRucy3mJP9djSC2MiCJ4PGDeq8lH3jKZz8Exbx4osEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862924; c=relaxed/simple;
	bh=EnsbfZuxC9RIxnGqfBuxuj/9JrH+GEm1z2N32vhH5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6L/06LbHnTCuFUml56k36w1dr5gsd6FbhR9U01JV8md93uW/euYv6zwZpD9qwV/ZuGq3/IByQvHx4qX/kI1Hnh9pOM06AsTSt16pr8EEW+uesZuaG2zxKAk7NZ3sOuFWepHwBqCCsrg4YY1HP+DfZsK4TOyZQaKmAuYwU75TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r8so0Xgm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r8so0Xgm"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896ff127650so76294446d6.3
        for <damon@lists.linux.dev>; Mon, 23 Feb 2026 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771862921; x=1772467721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=r8so0XgmKQIR0u05XHMEp8TlVv1/UkU7e2H0f6+RWE9ptW3xk4HVC4oi4izLwEhaHM
         2IdlHdDCTi03UoZ9Sx8+6w1yVcGOs3ZxnvKVhfBPZpkvCaFQ2nVRnoNq3fhk4jB48/nK
         wihfCoV7iP+iPx4J+Z8H7ERndjWWoPUPHSwPSWtdB7y9a91KUCwoBmKNt+LftYUpFHpW
         FR4+IcwFa/6wHy5Hb7BwsmaIRw13eEu3MDdHW4z6D/WT9Xe9dsgsL+gCUXEY7HKKT12v
         pqhGM25MfHYv0Dd7C/VbA6mFhMHLXRh30Wsd2TEU3/smFerOav99yOVuHv6V3hVG3jzi
         L06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862921; x=1772467721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=TWM9yz8AAhA5ar8KywdUzTOx2rPU9NdPsQC63p2PvivoYyUCVEdnzitrBNAL9Ua9jJ
         MuNlnOD9/1ilRO1AwBEF/FWNA8pl3fn2czcsMAOTk/IhlQAQ10lOJ39HYLPxMMKbLwSe
         0kE2dbzynK6LC6oPpig/xxoCRwpsoO+AnsfTmjN3L64dGDThknFuiZ344Rgpa37t4Sey
         yLH5T6EqlWmLkGgKe6vkFklHF51HHrXRe16AxnQ7BrnvPuqxAKM8tE6Hcf78OnQbSl3t
         G9XLFG3cxqR1l/bmjkZXXHqGbqaKT4OqCYQvMcobMW8tcrnl+XKi30aK9FhRRNoXmxAu
         Q5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVNHGDiTdxN+LStxlbTDCqjGM0XIbf5Vj2ztlpgLXqXZr8BG7E2sqa3FsWhGjYx3Qw/BmFObA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4MHQFVuz8WQGuZnJpG4Q3DZgqAbWxwuqk7e5sLSupsI31m66V
	ucz/NpP3kVqn1+sGG0ZIdXe5QcinoRQHRJuDV79u5B4li8s7thx0ZYk8d76ESCPknrk=
X-Gm-Gg: AZuq6aJvLavc9e8hJOgHDjeJ+JHV1K4goCYo7pXobN6JJuvY9kSq3cYeyM0xPmM98ek
	3bhsepjOKFN5rlsWkpTBxtzf0zmxoQskNeljcET0XSYKdQcIAm106zJh/WigoSB9k+Uc18GE4op
	legKcHAtONQxaDcC4laA/u4saquN9yrvfWFjdg0t4awqnGOJTRpyy3viC0V9L4K0/crRkhyOwD1
	NsoASGlqV6bm7Ad/t/hPYjbbzcD23zCYx8yv8sk5YpqwqnylnvvLzd+7DOnwCl6z3hB0NbrLbDE
	TZ9Gef+7f+B7Wr1vkY5T7dEonQO5xtACdYHQ+zxZELwGEyxMZWEVGAgyaltBftC2A46ESmsv/uj
	XiZdKxckuNRlh6rZDdLuHlPzSVxKh6IvP/vPdYYtgqfeh4zLN8ZVK6WqKFK1DVo8L9tvdJ/PaGJ
	VrC/pm4F5Mk5fpKqZdpa/9Scknb9TWv0FGjHWVEvncPvqxIXdKZUu+Fv3/xE/lmjRyZWM4tXWbI
	MSiy0tdx8P3TyXR8aDD
X-Received: by 2002:a05:622a:1922:b0:4f3:5835:e946 with SMTP id d75a77b69052e-5070bca9868mr136790871cf.55.1771862921369;
        Mon, 23 Feb 2026 08:08:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm71259831cf.10.2026.02.23.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:08:40 -0800 (PST)
Date: Mon, 23 Feb 2026 11:08:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
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
Message-ID: <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>

On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> > 
> > I'm concerned about adding more special-casing (similar to what we already
> > added for ZONE_DEVICE) all over the place.
> > 
> > Like the whole folio_managed_() stuff in mprotect.c
> > 
> > Having that said, sounds like a reasonable topic to discuss.
> > 
> 
> Another option would be to add the hook to vma_wants_writenotify()
> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> 

scratch all this - existing hooks exist for exactly this purpose:

	can_change_[pte|pmd]_writable()

Surprised I missed this.

I can clean this up to remove it from the page table walks.

Still valid to question whether we want this, but at least the hook
lives with other write-protect hooks now.

~Gregory
