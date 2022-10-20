Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D97E
	for <damon@lists.linux.dev>; Thu, 20 Oct 2022 01:18:13 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id p6-20020a17090a748600b002103d1ef63aso1593075pjk.1
        for <damon@lists.linux.dev>; Wed, 19 Oct 2022 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi8Swr2Se9yK2QnqTbiKVCd+C+pIZT/K8pMCJe5U8KU=;
        b=hk7zd0KSMO1hHEqZfDqkL0C3L0nNEwE6iAleU/FAzA32kS8DK3dqTMkBqV6TaipPLC
         3JVvANEahbUVqLkntTbzEb3x22o3J+hwh9jzeSWAH+I/HrSo7PsIc54GHoWOR3fUVlDF
         KULteRe5Oc83sB3dUEVg3GLGbI6neOnMm21IesyzSRDYZgqTCa/TaAIoJT/I82XR2zyk
         AMsgrLOobBjm+eIjM5THeklKVeOqv+Ar5QGYdZ3JUgBpnQsw/yH8Gml1AyZU4xcBYzgO
         zjxOxYu1X4W+30B49giTpywKA2MkBMxYn4ZQ6eeT78YmtD+iVjPDeLPsGYxIm9XZwTjN
         8KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi8Swr2Se9yK2QnqTbiKVCd+C+pIZT/K8pMCJe5U8KU=;
        b=r9qjQLqvmNi9xNeMIVMSQr0lD2ArwV8kDGQjVqwChNmkK3RC5qdanjHkS/cakbO6tU
         uVIkWzeiE3ZcN3zIwZDd+GYvG86q+y39txl8Qums6HKQH9260rJmp5wWrpjzn/e0Y5sO
         /jMI4fdCBgNeY+LCKd8pShwSvguJEc5FvkCN6strgtVxeheAYON8nYocedqNRptRvaK8
         1KrhvobVp9mWIojbQWS7ltCmZuM/6WvKrOcBbJLG9+PUkL9UgRwFKjSdzQ3E0X6b072e
         S9i/NYGKZYMWXKX55ZHBteL9NKFTILq3nyfb2vbYsCRcnsNm5ZD4Vv+zxhMhxNPVY1rE
         PADw==
X-Gm-Message-State: ACrzQf3VNaieV6zwlhG2GXWZNVByWtIPHgUTYpn+FzpLiKms/pmqz5ef
	6WI9P8icbvL98TyaGWRJsu5SaT2mAH2DxjOBRUfwtkC5DeA=
X-Google-Smtp-Source: AMsMyM4PoKuWyihbKpA9ZKffzqRq5NAccBpHI4ms6qdUZc2ycsM+EW44/BRJSGoWPjO74RgttfSYXsCxpDfUR2psXHI=
X-Received: by 2002:a17:90b:4a4d:b0:20d:4dc7:fa72 with SMTP id
 lb13-20020a17090b4a4d00b0020d4dc7fa72mr12552635pjb.86.1666228693145; Wed, 19
 Oct 2022 18:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEZ6=UN4jagT49VHPr4oM0BSqUOybFyty85hrWKeKAq0QApSXA@mail.gmail.com>
 <20221020004344.99662-1-sj@kernel.org>
In-Reply-To: <20221020004344.99662-1-sj@kernel.org>
From: Vinicius Petrucci <vpetrucci@gmail.com>
Date: Wed, 19 Oct 2022 20:17:36 -0500
Message-ID: <CAEZ6=UOs_k7NwrdZqg4v7UdYZG7JeqnV9Gv4_Zu957ASG1SGaQ@mail.gmail.com>
Subject: Re: Issue while testing new fvaddr feature
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

> So, that means the script was trying to 140437117468672-140438191214591 of the
> masim's virtual address space range as the first monitoring region, and
> 140436041629696-140438191214591 of the range as the second monitoring region.
>

Oh. Jeez. Now I see a dumb oversight:

end2=$(($start1+$size1-1))

should be:

end2=$(($start2+$size2-1))

I should have tried one region at a time and debugged each region more
thoroughly... my bad!

> As you can show, the two ranges are overlapping.  DAMON sysfs interface assumes
> the regions will not overlap, and in order.  That is, your script enters
> invalid regions, and therefore DAMON returns the error.

With your kind help and explanation, everything makes total sense now.

Thanks!
