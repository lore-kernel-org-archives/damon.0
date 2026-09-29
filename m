Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF94E3245;
	Tue, 29 Sep 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700972; cv=none; b=PRrnH/O+dqYIznDO4qdIGo5NADusJrosZnMdsWgMAHbktLLzv/39I3RjKZ2Tc4XNDVQ5pY0oRFaYmqQpqeFIKbI1shD2UPJcwuWPzpQnoHA1xaMMetc9EMsV1x1hdr8/3kaVIa/mywbLeTQJceYCZGTXrtuyzLLZTJtp9XCl+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700972; c=relaxed/simple;
	bh=16eDnmW6d9j2qGyycx8dUFUen29NtDA8WIDiJlzWxQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRLdYEoiovNneXgJuVqTa82bUG1r23hhXcB48a1hJxPs90QIFlQXlUzIDiutUVg8mA1AxiLNrQUgx0XfDNr2J0zXHHueMoSzoO/BEjtgQYbDVuhZmjbc1eY2Hmb+X9oeiSlku9MHhzVR9sK0qwYWrG1Oj3dftFgJfz8409kPRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXMJ4rbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXMJ4rbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FAE1F00893;
	Tue, 29 Sep 2026 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790700970;
	bh=JObT0OREbGaoxND8X7X5KvjjaI/mO0enYNHTriKbuw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXMJ4rbtSxjHcIVMOCN+vgFI1FVUqOnLCQ2ZEeXIyPnSSlH+OgnRdosevKXUItt/l
	 MoMgKYlJrjRUPMZBEiDY19fsS4W/tkgxFcO5n9CsJeWMQK7X1UrddnbzSPx2uCtixn
	 awYB2+tvvjI2XVI1XgS8XyUDBKU39mQubmPnoq4f94Le+qhRQvUc5Un+1tY6PtnTqI
	 JgG/OMqY4NrXNlzc19Ls543As+r/LP55URHCm7sdopJOHonVSsO/NdQkEQoO+equq8
	 NAg9jqUScgr6lE1EnUQD5+vIRUf51vmB3t1ZByGeDD5lumhZivPTH4KMA69fmcRQC3
	 jfbWsH0Gwl6zA==
From: SJ Park <sj@kernel.org>
To: Jialiang Huang <huang-jl@deepseek.com>
Cc: SJ Park <sj@kernel.org>,
	lance.yang@linux.dev,
	baohua@kernel.org,
	damon@lists.linux.dev,
	david@kernel.org,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com,
	linux-mm@kvack.org,
	mst@redhat.com,
	ryncsn@gmail.com,
	virtualization@lists.linux.dev,
	xueyuan.chen21@gmail.com,
	xiang@kernel.org
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Date: Tue, 29 Sep 2026 09:56:03 -0700
Message-ID: <20260929165603.49436-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929123241.1408414-1-huang-jl@deepseek.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 20:32:41 +0800 Jialiang Huang <huang-jl@deepseek.com> wrote:

> Hi all,
> 
> I'm an engineer at DeepSeek. Thanks for the discussion, and thanks
> to everyone working on DAMON and virtio-balloon free-page reporting.
> They have been very useful for our workloads.

So glad to hear this.  And thank you for sharing your use case!

[...]
> We have not yet fully explored how best to tune the DAMON and free-page
> reporting parameters for our workloads. For example, the kernel's default
> free-page reporting granularity is 2 MiB, which is fairly coarse:
> reclaiming cold pages does not necessarily produce free blocks of that
> size. We still need to evaluate how finer reporting granularity and
> different DAMON settings affect memory savings and workload performance.

I agree the reclaim-reporting granularity mismatch could be a room to improve.
As I also mentioned on my previous reply, this was one of the main motivations
of Access/Contiguity-aware Memory Autoscaling [1] proposal.  As also mentioned
on the previous reply, the project made no much progress yet, though.

[1] https://lore.kernel.org/all/20240512193657.79298-1-sj@kernel.org/


Thanks,
SJ

[...]
