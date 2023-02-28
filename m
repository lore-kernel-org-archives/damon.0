Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DD3D79
	for <damon@lists.linux.dev>; Tue, 28 Feb 2023 22:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBA8C4339B;
	Tue, 28 Feb 2023 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677623942;
	bh=d4lBrhKPB0jOyh0au68MrD6u+KOd9aGeSx3XzB0078I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SbHQ3IYfgGH2M4K+4QG0XJHcQXbrNWbSLhU3DR3E7/36PUh/kVUjiPvVljfy9FSwA
	 PUzHJ/S5K06AfV9buE6DKOmz9fr552kLm2Mg/aAq+fktL17F5zg0OUNp6pXk4X3k+v
	 SxDH5Q4jTMCIZ+Ug9U+1BLJiBEobpSUsPoaIqx2sJHcmro6cDDUJPXeV/tuLRJ/Ulj
	 3Ph0/+D14/qrnw/tPGM0HKnzjHMIRN7w0t/cjxowauVZFs71V9erKshha4b05zQwuJ
	 Xbv3zpPSZTxiT/KKB6p10+NaL+N59T4HdBfqp7sQdjPOCxLbSMUHp03hYf6hMn0UGY
	 EkGgIdQbAXG0w==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: "T.J. Alumbaugh" <talumbau@google.com>,
	lsf-pc@lists.linux-foundation.org,
	"Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
	hch@lst.de,
	kai.huang@intel.com,
	jon@nutanix.com,
	Yuanchu Xie <yuanchu@google.com>,
	linux-mm <linux-mm@kvack.org>,
	damon@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] VM Memory Overcommit
Date: Tue, 28 Feb 2023 22:38:59 +0000
Message-Id: <20230228223859.114846-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d1c562e2-58a5-14b0-9db9-de1c492fe921@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Feb 2023 10:20:57 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 23.02.23 00:59, T.J. Alumbaugh wrote:
> > Hi,
> > 
> > This topic proposal would be to present and discuss multiple MM
> > features to improve host memory overcommit while running VMs. There
> > are two general cases:
> > 
> > 1. The host and its guests operate independently,
> > 
> > 2. The host and its guests cooperate by techniques like ballooning.
> > 
> > In the first case, we would discuss some new techniques, e.g., fast
> > access bit harvesting in the KVM MMU, and some difficulties, e.g.,
> > double zswapping.
> > 
> > In the second case, we would like to discuss a novel working set size
> > (WSS) notifier framework and some improvements to the ballooning
> > policy. The WSS notifier, when available, can report WSS to its
> > listeners. VM Memory Overcommit is one of its use cases: the
> > virtio-balloon driver can register for WSS notifications and relay WSS
> > to the host. The host can leverage the WSS notifications and improve
> > the ballooning policy.
> > 
> > This topic would be of interest to a wide range of audience, e.g.,
> > phones, laptops and servers.
> > Co-presented with Yuanchu Xie.
> 
> In general, having the WSS available to the hypervisor might be 
> beneficial. I recall, that there was an idea to leverage MGLRU and to 
> communicate MGLRU statistics to the hypervisor, such that the hypervisor 
> can make decisions using these statistics.
> 
> But note that I don't think that the future will be traditional memory 
> balloon inflation/deflation. I think it might be useful in related 
> context, though.
> 
> What we actually might want is a way to tell the OS ruining inside the 
> VM to "please try not using more than XXX MiB of physical memory" but 
> treat it as a soft limit. So in case we mess up, or there is a sudden 
> peak in memory consumption due to a workload, we won't harm the guest 
> OS/workload, and don't have to act immediately to avoid trouble. One can 
> think of it like an evolution of memory ballooning: instead of creating 
> artificial memory pressure by inflating the balloon that is fairly event 
> driven and requires explicit memory deflation, we teach the OS to do it 
> natively and pair it with free page reporting.
> 
> All free physical memory inside the VM can be reported using free page 
> reporting to the hypervisor, and the OS will try sticking to the 
> requested "logical" VM size, unless there is real demand for more memory.

I think use of DAMON_RECLAIM[1] inside VM together with free pages reporting
could be an option.  Some users tried that in a manual way and reported some
positive results.  I'm trying to find a good way to provide some control of the
in-VM DAMON_RECLAIM utilization to hypervisor.

Hope to attend this session and discuss about that together.

[1] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html


Thanks,
SJ

> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
