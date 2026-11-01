Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793558052;
	b=s2hUv3S/ZuLSQrao18cOjsFoCZCC8ys3JCB7IPS6tdZnpYFGcc/VtAdEPvsM4/BbnR2b
	 JBO7dv4TlhriT3dt5F0XTG9mTcQsbx3qnGtAf4YOCgd/orrHV0KQE6/e2SlHvHRb2Vo6m
	 CyM6+2r2ZsSm5onzr6KIrNdNt3YS9E5pXUrYXIRPYhv2JAJr/rwoyrqm4YAp8fGWxAPdm
	 02UuG40mUUYNp2WQboDTL2+8V1/IeKgwlc/ox2pKKH83zlvmFm2VBMTMGEg/dB9D6yPRu
	 8l3mwNXi+cO5ir2Y0X4oZDlMYi07+KWQfGWYa3h9z9Bs7f/YAQYGVYzdYFruh6zGN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mdcb8PA8Fd6Cc1lT/iQNz2eYhuJFQtFMCUvyRyZT5cY=;
	b=cS7//4zHjdeSLfotgHKMtW3pVPcyB9hmEFOBzedxHdtWvucSueUK03IgJDlyDddhxKkK
	 HnVhPjrkd1ZWCkSA57ppncnlS8pMYWmFaHo9yrsQTJS9TZAA8jKnypOkZHuMhauwYR8YE
	 cJyaQvijOVvj//A+BaraRsJ5K9RvbfLT0aPVy1plenIVxKG74ywRq0ehyX5TVzkUJiEyz
	 Q28xaPNRWa2TsYycI3XH1gvkj1RdEn2lEjTu1ulvaQNtHZ/R+PY9FJ1BaYpXrSbv9QB0K
	 Ra4Pc5zbLTliWimTHEKjx3twWr3z3D+3Dx7RN3gEE2SXaz5Hm1Kv7rPbnRMcNDZWzRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLm3dxmD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD47606A324;
	Sun,  1 Nov 2026 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLm3dxmD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAE51F000C1;
	Sun,  1 Nov 2026 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793558051;
	bh=Mdcb8PA8Fd6Cc1lT/iQNz2eYhuJFQtFMCUvyRyZT5cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLm3dxmDedMrL0uJIydX4V5pvwijynFBnvMmkO6AIa0gsNMiytEFTqd9cpmP0BfeW
	 ZGWcQpNCYUIqDD7t+eNji1CYS0nnQLYbFzUG63Fm7Lb5artoBEnMRWXTJZNQw5q8FE
	 E1ZVVghFjQeJSsWKS+GmlMNUhWXooFCdo+pMWFxy8XomwZ8J655cLKN/a0++FZrsL3
	 ReT6z0RPW/G+APAN9gLEKHp3PUIXWkUJVAQF8gQfyxNz8I69AEv7RC1MdQJg0KuGMF
	 FbrTg+FmcBnCO58kp4sOFyUhd+oVWYjd7vSmMYWrDwigh8wLQ3zXULhDszeWbUu86s
	 Ck5iniqhfHDlw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v0] Docs/mm/damon/design: document data attributes report infra design (beyond page table accessed-bit milestone 2)
Date: Sun,  1 Nov 2026 10:34:04 -0800
Message-ID: <20261101183404.85322-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017195747.89961-1-sj@kernel.org>
References: 
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

On Sat, 17 Oct 2026 12:57:45 -0700 SJ Park <sj@kernel.org> wrote:

> The "beyond page table accessed-bit DAMON extension" project [1]
> milestone 2 is for building the basic infrastructure for continued
> extension.  After starting it, I studied perf event little and found a
> few demons in details.  I therefore spent time on high level design.  As
> it started looks like making sense to me, I'd like to share the humble
> design first and get feedback from more eyeballs.
> 
> Add a blueprint of the milestone 2 as a high level design document.
> Describe the API and ABI of data attribute report infrastructure, and an
> example use case of it for per-CPUs write-only monitoring.  The API and
> ABI will later be extended for more data attributes reporters utilizing
> AMD IBS, Intel PEBS, Arm SPEs like h/w features and any possible
> DAMON-external reporter kernel components.
> 
> Request for comments
> ====================
> 
> This is an RFC for high level design discussion, so no implementation is
> provided.  Comments I want to receive include but not limited to below.
> 
> Does the idea for perf CPU cycle sampling based access monitoring makes
> sense?
> 
> Does the design provides clear idea about how it can be extended for the
> future extensions that already scoped for milestone 3 (AMD IBS, Intel
> PEBS, Arm SPE)?
> 
> For the foreseeable extensions (AMD IBS, Intel PEBS, Arm SPE), would the
> required change minimum and maintainable?
> 
> Next steps
> ==========
> 
> I will start implementing the infrastructure and perf CPU cycle sampling
> based access monitoring as described in this patch.  It will go through
> the normal development process.  Delivery of it will be the completion
> of the milestone 2.  As set on the initial roadmap [1], ETA of the
> delivery is LSFMMBPF'27.  No delay is expected so far.
> 
> [1] https://lore.kernel.org/all/20260525225208.1179-1-sj@kernel.org/
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  Documentation/mm/damon/design.rst | 44 +++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index a465e34bb1d9c..1e699e3f8a496 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -433,6 +433,50 @@ monitoring.
>  Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
>  can use the mode.
>  
> +Data Attributes Reporting
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Infrastructure for receiving attribute information from DAMON-external kernel
> +components.
> +
> +Because DAMON is not hooked in every place but runs in its own worker thread,
> +it cannot retrieve some types of data attribute information by itself.  Many of
> +those are available to DAMON-external kernel components such as perf event
> +callbacks and page fault handler.  For such cases, DAMON provides attributes
> +reporting infrastructure.  Using its API, any kernel components can report
> +their finding to DAMON.
> +
> +The API for doing the report is a function, damon_report_attrs().  The function
> +receives the attribute information and saves it in DAMON's internal buffer.
> +The function is safe to be called in any context including NMI.  The internal
> +buffer has a fixed size and keeps only latest reports of the size.  Because one
> +buffer size doesn't fit all, multiple report buffers of different size and
> +rules can be generated and shared by multiple reporters.  DAMON provides API
> +for such management of report buffers.  damon_report_attrs() can specify into
> +which buffer the report should be saved.  DAMON user interface (ABI) for doing
> +the buffer setup, and enable/disable reports of supported types is also
> +supported.

I allowed callers/users to manage the buffers because I didn't have a
confidence at maanging the buffers in a good way.  But I now think it was not a
good design choice.

First of all, it is offloading decision to users.  I also feel like this design
exposes too much internal implementation details to users.  It would be better
to let DAMON just manage it.  If it turns out to be too suboptimal, we can
later consider optimizing it and even let users control it if really needed.

Letting M:N reports:queue routing makes it quite complicated, too. 

So, unless others object, I will change the design to hide the report buffers
management from users.

> +
> +The data attribute probe supports the reports.  The probes can be configured to
> +hit for a given memory region depending on the existence of specific types of
> +reports that associated with the memory region in given report buffers.
> +
> +For example, per-CPUs write-only monitoring can be configured using this
> +infrastructure like below.
> +
> +The user sets a report buffer and enable CPU instruction sampling report for
> +the buffer.  DAMON will enable perf event counter for CPU cycles sampling.  The
> +sampling callback will save the sampling time CPU instruction and the id of the
> +CPU that was executing it, into the DAMON report buffer, using
> +damon_report_attrs().  DAMON can automatically adjust the perf event sampling
> +frequency to minimize old report drops due to the buffer size limit.
> +
> +The user further sets a DAMON probe.  The probe hits for a given DAMON region
> +if a store instruction for a memory in the region that was executed from a
> +given CPUs group exists in the report buffer.  As a result, the probe hit
> +counts represent relative frequency of writes from a given CPUs group to a
> +given memory region.

My initial plan was to implement the above per-CPU write monitoring with the
milestone 2 patch series.  That's mainly because we don't want to have an API
without its callers.  But implementing perf cycle sampling would be no small
amount of code that require extensive tests.  It may take time and make the
patch series quite big.  I'm now trying to make it small and quick.

I find this report infrastructure could also be used for direct user reports.
That is, users might know which memory they are accessing, and want to ensure
DAMON knows that, by reporting their information using the report infra.  I
will expose an ABI for such direct user report, and connect it with the
reporting infra.  That would look similar to that of DAMOS quota goal
user_input metric.  I will continue implementing perf cpu cycle based report
producer implementation on top of it.  But maybe we could also just call the
user report as milestone 2, as there will be no more blockers for other works
like AMD IBS support.

Unless I get concerns on above plan, I will update this design patch and write
user ABI documents.  I will share those as RFC v0.1, and keep iterating the
documentation-only patches for continued design discussion until I get a
confidence in the interface design.

FYI, damon/next [1] tree may have hacky changes that could significantly be
changed in future.  Please don't rely on those.  Don't spend time on reviewing
those.  I sometimes regret I should named it 'damon/hack'.  Anyway, I will
share things that ready to be reviewed on this mailing list.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
