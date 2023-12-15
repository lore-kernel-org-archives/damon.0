Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DF10A1A
	for <damon@lists.linux.dev>; Fri, 15 Dec 2023 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="13555T45"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so45925e9.0
        for <damon@lists.linux.dev>; Fri, 15 Dec 2023 00:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702629237; x=1703234037; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH00aA121x0wt9tSYv6S52kB6dsUFNy2Wev1qwKspsw=;
        b=13555T45N0BXddb1mJvEuvyTaID+NKOyTjlHhEy+eV+Oai/nmVVScRaeaw3r9NKZx+
         K2CNgsttlQn4VOagtXYOwQJIbhneRcUJUPjAS/Bc93RXOS3Vbn1IWeFXyUa80y8H3KwI
         g+R8o95iF7eJe8N+5D4ofeIeI5jAxfKOFtmGNtxuaRuwIclb3y/2ez3xI0Fc+kNteFrV
         hsfBN1IVL4zCWqFKg9TUSCHrP7X3O+80omIhUXzs268H1/Z8uU1rXhZHhCBPMsoCaUtu
         muyP4f0e7jdU5MklSUCKUS7Ue9jCguOegBBsDQiWg1YmfsBk7/AKPf7Sb1wlZseZ4+pN
         aw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702629237; x=1703234037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH00aA121x0wt9tSYv6S52kB6dsUFNy2Wev1qwKspsw=;
        b=l+gDpQXpxfcluMkv20NVxd7s73Fk1vcp2OMJIkVxNcFZ0FSkfNw5yzD6qYKNQ10Kkv
         eYCNA0Knp4+r5TXuX9ui56l13g7LK7QDNGQIZ7wxjrpRhUGkXk+6hbcMs54De4zQ5g5c
         vnCXHR0bWUzD6GrS/zgQcOIycjtnBawxlOCwUW00Q7AQGaDvxCpPUWBPD3Yaz7guxk3d
         7sgLS5dH1mW5F2eExQHRzH2MyNbOKNc1tYg4Qw3oWibWd8u2QOKbCU9/fZfQ9/VB/2mv
         jKNYleMCluyOWjKMYDTHZqmIbmiv7I/Nh9eBkCgVKN/RV/zNYy2MNSfU60RwD++NK7ca
         RuOQ==
X-Gm-Message-State: AOJu0YyWoP8TbnqPgbm1YV75ESeE5kL1qQe9doQDAIJ37ueLClT0BccY
	cL7uRXByIPG42HtL9NsnDFbkYmd2RzSlFAAL5mk3XQ==
X-Google-Smtp-Source: AGHT+IHCuoXmKPQdsauUyid8g8apT+ABo8Z6QF3/4ZQ1AenTe8DJq9g9olKXx/VBUVe3CcDC3sKuimKTrwfQbh2Q6qU=
X-Received: by 2002:a05:600c:5113:b0:40c:329:d498 with SMTP id
 o19-20020a05600c511300b0040c0329d498mr624641wms.1.1702629237109; Fri, 15 Dec
 2023 00:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
In-Reply-To: <20231215074619.173787-1-aravinda.prasad@intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 15 Dec 2023 01:33:18 -0700
Message-ID: <CAOUHufZW8ZbNDnu3Cfc61oJ4FkXK+AbT90XpS5Ei++1_5mcFFQ@mail.gmail.com>
Subject: Re: mm/DAMON: Profiling enhancements for DAMON
To: Aravinda Prasad <aravinda.prasad@intel.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, s2322819@ed.ac.uk, sandeep4.kumar@intel.com, 
	ying.huang@intel.com, dave.hansen@intel.com, dan.j.williams@intel.com, 
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com, 
	alexander.kanevskiy@intel.com, Alan Nair <alan.nair@intel.com>, 
	Juergen Gross <jgross@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:42=E2=80=AFAM Aravinda Prasad
<aravinda.prasad@intel.com> wrote:
...

> This patch proposes profiling different levels of the application=E2=80=
=99s
> page table tree to detect whether a region is accessed or not. This
> patch is based on the observation that, when the accessed bit for a
> page is set, the accessed bits at the higher levels of the page table
> tree (PMD/PUD/PGD) corresponding to the path of the page table walk
> are also set. Hence, it is efficient to  check the accessed bits at
> the higher levels of the page table tree to detect whether a region
> is accessed or not.

This patch can crash on Xen. See commit 4aaf269c768d("mm: introduce
arch_has_hw_nonleaf_pmd_young()")

MGLRU already does this in the correct way. See mm/vmscan.c.

This patch also can cause USER DATA CORRUPTION. See commit
c11d34fa139e ("mm/damon/ops-common: atomically test and clear young on
ptes and pmds").

The quality of your patch makes me very much doubt the quality of your
paper, especially your results on Google's kstaled and MGLRU in table
6.2.
