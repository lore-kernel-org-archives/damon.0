Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=104.207.68.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170811;
	b=VniiPC9YTNDwN/pmldCm3hi2dkgLLwUtv1ReZS3+iydjjoxnQpaZhItetjpp8kLlccPV
	 LMlMC8lAKpYGDKCwJxzBIQyPyZT/CYPoyeREPmADKRqx+Vd1oeakbYPJapRsh3qPWlc+P
	 w4b//bryaAIap40bEgA7wla6NFMkoP1WPGBaKqsZ1T+ImIqBoG47kKWXdiiWVpv1soBLE
	 o+xwg522Hcp8lFhVDM9m7yhnrWvca7PY6gTnbyXb26gf9krPH+O1+ndCNzB4m9v1XDfSG
	 U4eiC8DSEVdFHc8fRHWbWBYZ3CkJPHTWHX9nmJ5DmApRucqAGh4LqD7PfZHPhd+PnQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170811;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=KCPw+q5p4Yyf7FYw3qSmU12ZFK/LfmJwMcs22RlGgSU=;
	b=WLcW8FAsl6E0hSaqsU296qn0VQiWTK4JJS4/zj1PaiTsJDGMWGR+q6CdGYg8x0mZXuXR
	 LuR5KNjnCVzbuQzdoUOPNCzSnVoh9EShkO4Y2nxkSH+wes+BmXv/MdN2skycI+bnxiFKM
	 iM4vdr2A5bSuXDIn7C/4c6nsDSPLHxvFT2nSC8ofUTiMngEcXlZ6tJ5M7UdvSNsPd9aW5
	 hG1Dv/jJ4MiS0t/zZ9HmrFMomZij/KC3Gk+9BsDtFhSRhE8pX6gR4J3cwE+y5FxBeB0zp
	 Q/YA86xzBM6avTZhbVYvtifU06qoX4fxu87GptqRxaAL3QfPRwAG8dKXhua/G8/cO8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=YFbaSadU;
	arc=none smtp.remote-ip=104.207.68.49
Received: from out-93wp-a49.jellyfish.systems (out-93wp-a49.jellyfish.systems [104.207.68.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D8606A33D
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 10:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 217D8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=YFbaSadU
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jWBVx0MHhz6tkK;
	Fri, 20 Nov 2026 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1795170791;
	bh=KCPw+q5p4Yyf7FYw3qSmU12ZFK/LfmJwMcs22RlGgSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFbaSadUIfqinCT95kZ4vNNrDGlY8vKSJxbuwUfzAAoiputof8HA2RVaXoC24tEdu
	 L6VK9zfchBxb9JVZCwD9ZjBuiQMO/6jcAeMMhB8eSCDsJp8PGQZJ664Ab9uctX62X0
	 PerJeDVirnbZBZqeso2rTWsFBfn7KlHST3oqX5thjoS0ZHNW07mF830vgIEN/qnFBb
	 yWj2Jv66UGZOpHZZgbKZ7KrdBX5Hs46yB3xrguNhRa37nP9hCOj8PyZoZZTCru8zhH
	 zUO0wgqxBsGQZVmWwuhFp8NexiSObO2miUzVbBYkPDiUP8YacQfdfIo+WYQ8Fmkhtn
	 rznaeIGJo1lSw==
From: Tianyi Chen <hi@tychen.cc>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Chris Li <chrisl@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Nico Pache <nico.pache@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregory Price <gourry@gourry.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	SJ Park <sj@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	Zicheng Wang <wangzicheng@honor.com>,
	Chen Ridong <chenridong@xiaomi.com>,
	Tal Zussman <tz2294@columbia.edu>,
	Xiang Liu <liuxiang.277@bytedance.com>,
	Ehab Ababneh <ehab.ababneh@intel.com>,
	Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Hui Zhu <hui.zhu@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	Maxim Muzafarov <maxmuzaf@gmail.com>,
	hi@tychen.cc
Subject: Re: [PATCH v5 00/17] mm/mglru: frequency guided promotion (MGLRU-FG)
Date: Fri, 20 Nov 2026 19:32:50 +0900
Message-ID: <20261120103250.1241429-1-hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAMgjq7Dnjsq4vid7H4usOB4f5AS8XzhG75mvf4-Y=an95gBERw@mail.gmail.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com> <20261119112357.275352-1-hi@tychen.cc> <CAMgjq7Dnjsq4vid7H4usOB4f5AS8XzhG75mvf4-Y=an95gBERw@mail.gmail.com>
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
X-Envelope-From: hi@tychen.cc

On Fri, Nov 20, 2026 at 01:33:32AM +0800, Kairui Song wrote:
> Thanks! That's good news.
[...]
> FG still doesn't track MADV_RANDOM accesses though, and still no
> proactive workingset shift protection. Refault distance will cover the
> rest including Maxim's case IIUC, as demonstrated before, it's better
> to do that later as it fits much better with FG merged first.

Thanks. Feel free to add, for the whole series as tested above
(the OpenSearch k-NN test, on 25fee5b1762b):

Tested-by: Tianyi Chen <hi@tychen.cc>

I'll rerun it on the refault distance series once it's posted.

Tianyi
