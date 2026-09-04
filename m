Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B83B27F3
	for <damon@lists.linux.dev>; Fri,  4 Sep 2026 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491891; cv=none; b=iF+KKuOdj7vzPloy7pwBlPIveWEC28Hgu5bzbPkxyBdCHD+Tdtygf4iBoJC/TiEW8kPcEYdSJJPvgH+8g7RchaWdiIopifOGSTFGThAo5y7x+dLWB1Bx1EXaY03VOMk/62JoVbHuObSuHh21juizEgsI4Pj+2mV1MVgRZhWuQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491891; c=relaxed/simple;
	bh=AIU6NGTW/RpZfTt6y2cuypcAmkoFDaCDqNNZTCJi0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxSNw9dx7k+NrW5r/p8EYarm+82yUx2hEhZMX/ZMBuFICVnY/FCIb50XO6qg3uOtWAx0Z3/xhiP5bR21hv+Y52PiSGgzSI5+JSB24SQjkfTHrVJtAOZoK3oIlpde4nRDBqqAgVHhcFWYAFUMFuUDEL1eQYnEGseFpKrBwD2KYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TMvCPDQy; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TMvCPDQy"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c08df8513so4492641cf.3
        for <damon@lists.linux.dev>; Thu, 03 Sep 2026 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788491887; x=1789096687; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I82bST350eZ9tF0sXAbqbqSO4hf+URoRFBA/uGedV7I=;
        b=TMvCPDQyOb/vTI12GLkN4vp7j6+ugwdbUzLy+CNCkZCnlED1/KJx8ZcvlrZaOWhudQ
         f1nONftzN6Izwu/bGGkxNf9wLko47wzSo0ys/0cDPTNj8Pv8gPIStbk0abka1vj2KeAF
         VJEhfqUOdiftbCra6JISz3WWsCq/OrQ2xdIfkvbPhxnBc8v5C7Yj4EWRF+jOKYUQWhd1
         9ZAJ4EWitEes/aeLELL8Yl5h5n5b1tnr/qDJuOlMDZcUDaDjm3eMp6Ve2T0/gMR512ID
         BH+vK9QSFcw1FE2lXhWvvuoU5OYfnCtNylatS0kqWsQxfFBuEQyz8phvLkg7tcpiRRV6
         AC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491887; x=1789096687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I82bST350eZ9tF0sXAbqbqSO4hf+URoRFBA/uGedV7I=;
        b=XezB1Y7Ln5hj7GNDdOsg9i+Vxn8NZ2sCKk8My1a3JvGRq1v8yn5l2Vz+6k98euoSQO
         ekAKaKVD9P9JaS0LQEMx5DuOjbdUqXoQR0gIIMBUFOr+zHGMYcZD1G1Qik3uCwk7p1vR
         mlTOIE3ex1Dslx6w8URPX9gj2K9SZZqLaqq8BEkHZvVIbih/6IAEtmlAPNgDiFK+9bSN
         hDCvcqbUIoOu2y2+b8Br5flmlxSW+OuIDToIXMd+1I2bPm62WTxRd356/PqlOH2E9ddA
         P+oZUhwUEzsc4yzNc1b5XDBeeO/68mFXAqcu+UBgnNDesrFfAkuLeqI80jGcnyf1tLKg
         F+4g==
X-Forwarded-Encrypted: i=1; AKwUvBwDGQgrbkEn8az1cNB//MCCu8Qk0/jW30y0a1gw4EOLNMeWycLLUaMjcsfiFa1klyyw0p/uTA==@lists.linux.dev
X-Gm-Message-State: AFuF++k5o8/VXhGqAldAK0a9a8L75/Hqx0Zo9MXyQfyljJHA6oRauNk1
	36C9qkwnIQrwg2GNT0tBz0sgAIEulKPu2vAJuSGEImnv+HCI/oTjJewRtPn2FffZI3s=
X-Gm-Gg: AYBFou0Vy/FAKxkiYy90zGKIk9oVbCiQP/CbmIJsxoOI3hKDr4yZFyxU3h0BUhqdl6A
	ePxS661IS5TdOD+L/d48LJ6vG0hZe7fsUd/8V/FMjpn2Jbwd+/X9cJc79/SuN8Ns8pyKrK/2miu
	blJej7QBEYF/TZeujh33uTPw3qFJSlnPUAy8pfwocb5AQUEnB9f7qLxz0SFqXPRsPbkTugjCfFH
	ECjKHcf2i9B2aGgaeNaIMk8Eyg2tLSqyM2pKw5IzXrZ248LCfALGBd7suCND72WoM+EIubEkMXf
	1SQ4Pu8zIcTvcu1a4PtqFMJRyPntK8YGL7c1g5jlRuIMzrsJaraDCORWXobqn6ITmW7I+5Pw2ER
	pRbcYHPBqKQnW+V631cOXhVGM7rgqt4EuIdZYkCV/25JV0C88jlYoLbp0WhuZ/uh9S1VwO0a+nC
	ZGM6RHB8UkdqimTJbzYIJfbytFiIcQb6zt+fdV2na80QceHRYRGFy5z/WgIYgKe55CrJcz3fGg4
	nPft7CyZGXtAyWLfSMhJSWxt1uw2pVHH1PmZZtM1skdz90h4xDxi5k=
X-Received: by 2002:a05:622a:1c18:b0:52d:4f43:d5b0 with SMTP id d75a77b69052e-530548bc5e0mr43078621cf.22.1788491887027;
        Thu, 03 Sep 2026 20:18:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305402a7b7sm11260161cf.3.2026.09.03.20.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 20:18:06 -0700 (PDT)
Date: Thu, 3 Sep 2026 23:18:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Qiqi Li <liqiqi23@huawei.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 25/36] mm/memory_hotplug: support N_MEMORY_PRIVATE
 node hotplug
Message-ID: <apo3bZab6qtCosQM@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-26-gourry@gourry.net>
 <6840c720-8cb7-46bb-a652-040c130a4427@huawei.com>
 <aoJaaYp30LnKLj1w@gourry-fedora-PF4VCD3F>
 <0334fe7d-d949-45f7-8914-3012cb11b740@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0334fe7d-d949-45f7-8914-3012cb11b740@huawei.com>

On Fri, Sep 04, 2026 at 09:05:39AM +0800, Qiqi Li wrote:
> On 8/17/2026 8:49 AM, Gregory Price wrote:
> > It would need to be reserved, and you could use numa emulation but
> > that's clunky.  I have an RFC for exactly this issue - though i haven't
> > pushed it further yet.
> > 
> > https://lore.kernel.org/all/20260610014517.253609-1-gourry@gourry.net/
> 
> Hi Gregory,
> 
> Sorry for the late reply.
> 
> I took a look at the exclusive-node RFC. The approach looks useful for
> device-backed private memory without a firmware-described NUMA node.
> Thanks for the pointer.
> 
> We are currently looking into the private-node and CRAM design as a
> whole. I noticed that CRAM was not included with the v5 series, and saw
> that others were also interested in a v5 version.
> 
> If you already have a CRAM branch or patches based on v5, even if they
> are still work in progress, would you mind sharing them? It would be
> very helpful for us to continue testing the overall design.
>

I dropped it off because it was starting to become unwieldly, but i am
continuing to maintain a branch on my github:

https://github.com/gourryinverse/linux/commits/scratch/gourry/cramtest/cram_72/

I have not posted a new version in some time and it has been reworked
significantly in the past few months - but I plan to talk about this
particular branch and the tests I've run with it at the device memory
LPC micro-conference.

I validated this branch against most in-tree (relevant) filesystems for
the page-cache extension, but I imagine the anon-only version subset is
the more immediately interesting for upstream development.

I may include the anon-only version in v6, but I've been a bit busy
shoring up the base private memory node core and implementing kernel
selftests and LTP tests to ensure there's no userland api regressions.

I hope to get something out later this month.

~Gregory
